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
   
   bit                        repeat_req = 0;
   uvma_axis_mstr_seq_item_c  mstr_seq_item ;
   bit [7:0]                  data_q[$]     ;
   uvma_axis_tdata_b_t        data          ;
   uvma_axis_tkeep_b_t        keep          ;
   
   foreach (seq_item.data[ii]) begin
      data_q.push_back(seq_item.data[ii]);
   end
   
   // First cycle
   `uvm_create_on(mstr_seq_item, p_sequencer.mstr_sequencer)
   keep = {`UVMA_AXIS_TDATA_MAX_WIDTH{1'b1}};
   for (int unsigned ii=0; ii<cfg.tdata_width; ii++) begin
      if (data_q.size()) begin
         data[ii] = data_q.pop_front();
      end
      else begin
         keep[ii] = 1'b0;
      end
   end
   mstr_seq_item.tvalid = 1;
   mstr_seq_item.tdata  = data;
   mstr_seq_item.tid    = seq_item.tid  ;
   mstr_seq_item.tdest  = seq_item.tdest;
   mstr_seq_item.tuser  = seq_item.tuser;
   mstr_seq_item.tkeep  = keep;
   mstr_seq_item.tstrb  = keep;
   mstr_seq_item.tlast  = 0;
   do begin
      `uvm_send_pri(mstr_seq_item, `UVMA_AXIS_MSTR_DRV_SEQ_ITEM_PRI)
   end while (cntxt.vif.tready !== 1'b1);
   
   // Transfer rest of data (if any)
   while (data_q.size()) begin
      `uvm_create_on(mstr_seq_item, p_sequencer.mstr_sequencer)
      keep = {`UVMA_AXIS_TDATA_MAX_WIDTH{1'b0}};
      for (int unsigned ii=0; ii<cfg.tdata_width; ii++) begin
         if (data_q.size()) begin
            data[ii] = data_q.pop_front();
            keep[ii] = 1'b1;
         end
      end
      if (data_q.size()) begin
         mstr_seq_item.tvalid = 1'b1;
         mstr_seq_item.tdata  = data;
         mstr_seq_item.tid    = seq_item.tid  ;
         mstr_seq_item.tdest  = seq_item.tdest;
         mstr_seq_item.tuser  = seq_item.tuser;
         mstr_seq_item.tkeep  = {`UVMA_AXIS_TDATA_MAX_WIDTH{1'b1}};
         mstr_seq_item.tstrb  = {`UVMA_AXIS_TDATA_MAX_WIDTH{1'b1}};
         mstr_seq_item.tlast  = 0;
      end
      else begin
         mstr_seq_item.tvalid = 1'b1;
         mstr_seq_item.tdata  = data;
         mstr_seq_item.tid    = seq_item.tid  ;
         mstr_seq_item.tdest  = seq_item.tdest;
         mstr_seq_item.tuser  = seq_item.tuser;
         mstr_seq_item.tkeep  = keep;
         mstr_seq_item.tstrb  = keep;
         mstr_seq_item.tlast  =  1;
      end
      
      do begin
         `uvm_send_pri(mstr_seq_item, `UVMA_AXIS_MSTR_DRV_SEQ_ITEM_PRI)
      end while (cntxt.vif.tready !== 1'b1);
   end
   
   repeat (100) begin
      `uvm_create_on(mstr_seq_item, p_sequencer.mstr_sequencer)
      mstr_seq_item.tvalid = 0;
      `uvm_send_pri(mstr_seq_item, `UVMA_AXIS_MSTR_DRV_SEQ_ITEM_PRI)
   end
   
endtask : drv


`endif // __UVMA_AXIS_MSTR_DRV_VSEQ_SV__
