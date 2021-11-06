// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_MON_VSEQ_SV__
`define __UVMA_AXIS_MON_VSEQ_SV__


/**
 * TODO Describe uvma_axis_mon_vseq_c
 */
class uvma_axis_mon_vseq_c extends uvma_axis_base_vseq_c;
   
   `uvm_object_utils(uvma_axis_mon_vseq_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_mon_vseq");
   
   /**
    * TODO Describe uvma_axis_mon_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_axis_mon_vseq_c::monitor()
    */
   extern virtual task monitor();
   
endclass : uvma_axis_mon_vseq_c


function uvma_axis_mon_vseq_c::new(string name="uvma_axis_mon_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_mon_vseq_c::body();
   
   `uvm_info("AXIS_MON_VSEQ", "Monitor virtual sequence has started", UVM_HIGH)
   forever begin
      fork
         begin
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            monitor();
         end
         
         begin
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            wait (cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
         end
      join_any
      disable fork;
   end
   
endtask : body


task uvma_axis_mon_vseq_c::monitor();
   
   uvma_axis_mon_trn_c       mon_trn     ;
   uvma_axis_mstr_mon_trn_c  mstr_mon_trn;
   uvma_axis_slv_mon_trn_c   slv_mon_trn ;
   
   forever begin
      do begin
         get_slv_mon_trn (slv_mon_trn );
         get_mstr_mon_trn(mstr_mon_trn);
         if ((slv_mon_trn.tready === 1'b1) && (mstr_mon_trn.tvalid === 1'b1)) begin
            cntxt.mon_current_transfer.push_back(mstr_mon_trn);
         end
      end while (!((mstr_mon_trn.tlast === 1'b1) && (mstr_mon_trn.tvalid === 1'b1) && (slv_mon_trn.tready === 1'b1)));
      
      `uvm_info("AXIS_MON_VSEQ", $sformatf("Accumulated %0d transactions", cntxt.mon_current_transfer.size()), UVM_DEBUG)
      foreach (cntxt.mon_current_transfer[ii]) begin
         `uvm_info("AXIS_MON_VSEQ", $sformatf("cntxt.mon_current_transfer[%0d]=\n%s", ii, cntxt.mon_current_transfer[ii].sprint()), UVM_DEBUG)
      end
      
      // Process queue of transactions into final monitor transaction
      // TODO Add mechanism for adding error checkers
      // TODO Check that simple implementation of keep/strobe is correct vs. spec
      mon_trn = uvma_axis_mon_trn_c::type_id::create("mon_trn");
      mon_trn.set_initiator(mstr_mon_trn.get_initiator());
      mon_trn.cfg   = cfg;
      mon_trn.tid   = cntxt.mon_current_transfer[0].tid  ;
      mon_trn.tdest = cntxt.mon_current_transfer[0].tdest;
      mon_trn.tuser = cntxt.mon_current_transfer[0].tuser;
      mon_trn.set_timestamp_start(cntxt.mon_current_transfer[0].get_timestamp_start());
      mon_trn.set_timestamp_end  (cntxt.mon_current_transfer[$].get_timestamp_end  ());
      do begin
         mstr_mon_trn = cntxt.mon_current_transfer.pop_front();
         for (int unsigned ii=0; ii<cfg.tdata_width; ii++) begin
            if ((mstr_mon_trn.tstrb[ii] === 1'b1) && (mstr_mon_trn.tkeep[ii] === 1'b1)) begin
               mon_trn.data.push_back(mstr_mon_trn.tdata[ii]);
            end
         end
      end while (cntxt.mon_current_transfer.size());
      mon_trn.size = mon_trn.data.size();
      cntxt.mon_current_transfer.delete();
      
      `uvml_hrtbt_owner(p_sequencer)
      write_mon_trn(mon_trn);
   end
   
endtask : monitor


`endif // __UVMA_AXIS_MON_VSEQ_SV__
