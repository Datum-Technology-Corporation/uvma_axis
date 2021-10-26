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


`ifndef __UVMA_AXIS_MSTR_DRV_VSEQ_SV__
`define __UVMA_AXIS_MSTR_DRV_VSEQ_SV__


/**
 * TODO Describe uvma_axis_mstr_drv_vseq_c
 */
class uvma_axis_mstr_drv_vseq_c extends uvma_axis_mstr_base_vseq_c;
   
   `uvm_object_utils(uvma_axis_mstr_drv_vseq_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_mstr_drv_vseq");
   
   /**
    * TODO Describe uvma_axis_mstr_base_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_axis_mstr_vseq_c::drv()
    */
   extern virtual task drv(ref uvma_axis_seq_item_c seq_item);
   
endclass : uvma_axis_mstr_drv_vseq_c


function uvma_axis_mstr_drv_vseq_c::new(string name="uvma_axis_mstr_drv_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_mstr_drv_vseq_c::body();
   
   `uvm_info("AXIS_MSTR_DRV_VSEQ", "MSTR driver virtual sequence has started", UVM_HIGH)
   super.body();
   
endtask : body


task uvma_axis_mstr_drv_vseq_c::drv(ref uvma_axis_seq_item_c seq_item);
   
   bit                        skip_next = 0;
   uvma_axis_mstr_seq_item_c  mstr_seq_item;
   bit [7:0]                  data_q[$]    ;
   uvma_axis_tdata_b_t        data         ;
   
   // Assert tvalid
   `uvm_info("AXIS_MSTR_DRV_VSEQ", $sformatf("Waiting on SLV for transfer:\n%s", seq_item.sprint()), UVM_DEBUG)
   do begin
      `uvm_create_on(mstr_seq_item, p_sequencer.mstr_sequencer)
      `uvm_rand_send_pri_with(mstr_seq_item, `UVMA_AXIS_MSTR_DRV_SEQ_ITEM_PRI, {
         tvalid  == 1'b1;
      })
   end while (cntxt.vif.tready !== 1'b1);
   `uvm_info("AXIS_MSTR_DRV_VSEQ", $sformatf("Data transfer has begun for seq_item:\n%s", seq_item.sprint()), UVM_DEBUG)
   
   // Transfer data
   foreach (seq_item.data[ii]) begin
      data_q.push_back(seq_item.data[ii]);
   end
   while (data_q.size()) begin
      if (!skip_next) begin
         `uvm_create_on(mstr_seq_item, p_sequencer.mstr_sequencer)
         for (int unsigned ii=0; ii<cfg.tdata_width; ii++) begin
            data[ii] = data_q.pop_front();
         end
         if (data_q.size()) begin
            `uvm_rand_send_pri_with(mstr_seq_item, `UVMA_AXIS_MSTR_DRV_SEQ_ITEM_PRI, {
               tvalid == 1'b1;
               tdata  == data;
               tid    == seq_item.tid  ;
               tdest  == seq_item.tdest;
               tuser  == seq_item.tuser;
               tkeep  == seq_item.tkeep;
               tstrb  == seq_item.tkeep;
               tlast  == 1;
            })
         end
         else begin
            `uvm_rand_send_pri_with(mstr_seq_item, `UVMA_AXIS_MSTR_DRV_SEQ_ITEM_PRI, {
               tvalid == 1'b1;
               tdata  == data;
               tid    == seq_item.tid  ;
               tdest  == seq_item.tdest;
               tuser  == seq_item.tuser;
               tkeep  == '1;
               tstrb  == '1;
               tlast  ==  0;
            })
         end
      end
      else begin
         wait (cntxt.vif.clk === 1'b0);
         wait (cntxt.vif.clk === 1'b1);
      end
      
      if (cntxt.vif.tready === 1'b1) begin
         skip_next = 0;
      end
      else begin
         skip_next = 1;
      end
   end
   `uvm_info("AXIS_MSTR_DRV_VSEQ", $sformatf("Data transfer has ended for seq_item:\n%s", seq_item.sprint()), UVM_HIGH)
   
   `uvm_rand_send_pri_with(mstr_seq_item, `UVMA_AXIS_MSTR_DRV_SEQ_ITEM_PRI, {
      tvalid == 1'b0;
   })
   
endtask : drv


`endif // __UVMA_AXIS_MSTR_DRV_VSEQ_SV__
