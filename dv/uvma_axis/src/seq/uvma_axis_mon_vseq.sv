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
    * TODO Describe uvma_axis_mon_vseq_c::process_transfers()
    */
   extern virtual task process_transfers();
   
endclass : uvma_axis_mon_vseq_c


function uvma_axis_mon_vseq_c::new(string name="uvma_axis_mon_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_mon_vseq_c::body();
   
   `uvm_info("AXIS_MON_VSEQ", "Monitor virtual sequence has started", UVM_HIGH)
   forever begin
      fork
         begin : transfer
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            process_transfers();
         end
         
         begin : reset
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            wait (cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
         end
      join_any
      disable fork;
   end
   
endtask : body


task uvma_axis_mon_vseq_c::process_transfers();
   
   uvma_axis_mon_trn_c       mon_trn     ;
   uvma_axis_mstr_mon_trn_c  mstr_mon_trn;
   uvma_axis_slv_mon_trn_c   slv_mon_trn ;
   
   forever begin
      // Wait for start of transfer
      do begin
         fork
            get_slv_mon_trn (slv_mon_trn );
            get_mstr_mon_trn(mstr_mon_trn);
         join
      end while (((slv_mon_trn.tready !== 1'b1)) || (mstr_mon_trn.tvalid !== 1'b1));
      cntxt.mon_current_transfer.push_back(mstr_mon_trn);
      
      // Create transaction
      mon_trn = uvma_axis_mon_trn_c::type_id::create("mon_trn");
      mon_trn.set_initiator(p_sequencer);
      mon_trn.cfg = cfg;
      
      // Accumulate transfer data
      do begin
         get_slv_mon_trn (slv_mon_trn);
         get_mstr_mon_trn(mstr_mon_trn);
         if ((slv_mon_trn.tready === 1'b1) && (mstr_mon_trn.tvalid === 1'b1)) begin
            cntxt.mon_current_transfer.push_back(mstr_mon_trn);
         end
      end while (mstr_mon_trn.tlast !== 1'b1);
      
      // Process queue of transactions into final monitor transaction
      // TODO Add mechanism for adding error checkers
      mon_trn.set_timestamp_end($realtime());
      mon_trn.size  = cntxt.mon_current_transfer.size();
      mon_trn.tid   = cntxt.mon_current_transfer[0].tid  ;
      mon_trn.tdest = cntxt.mon_current_transfer[0].tdest;
      mon_trn.tuser = cntxt.mon_current_transfer[0].tuser;
      mon_trn.tkeep = cntxt.mon_current_transfer[$].tkeep;
      foreach (cntxt.mon_current_transfer[ii]) begin
         mstr_mon_trn = cntxt.mon_current_transfer[ii];
         mon_trn.data.push_back(mstr_mon_trn.tdata);
      end
      cntxt.mon_current_transfer.delete();
      
      `uvml_hrtbt_owner(p_sequencer)
      write_mon_trn(mon_trn);
   end
   
endtask : process_transfers


`endif // __UVMA_AXIS_MON_VSEQ_SV__
