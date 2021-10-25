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


`ifndef __UVMA_AXIS_IDLE_VSEQ_SV__
`define __UVMA_AXIS_IDLE_VSEQ_SV__


/**
 * TODO Describe uvma_axis_idle_vseq_c
 */
class uvma_axis_idle_vseq_c extends uvma_axis_mstr_base_vseq_c;
   
   `uvm_object_utils(uvma_axis_idle_vseq_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_idle_vseq");
   
   /**
    * TODO Describe uvma_axis_idle_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_axis_idle_vseq_c::mstr()
    */
   extern task mstr();
   
   /**
    * TODO Describe uvma_axis_idle_vseq_c::slv()
    */
   extern task slv();
   
endclass : uvma_axis_idle_vseq_c


function uvma_axis_idle_vseq_c::new(string name="uvma_axis_idle_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_idle_vseq_c::body();
   
   `uvm_info("AXIS_IDLE_VSEQ", "Idle virtual sequence has started", UVM_HIGH)
   case (cfg.drv_mode)
      UVMA_AXIS_DRV_MODE_MSTR: mstr();
      UVMA_AXIS_DRV_MODE_SLV : slv ();
   endcase
   
endtask : body


task uvma_axis_idle_vseq_c::mstr();
   
   uvma_axis_mstr_seq_item_c  mstr_seq_item;
   
   forever begin
      `uvm_create_on(mstr_seq_item, p_sequencer.mstr_sequencer)
      // TODO Add support for cfg.drv_idle
      `uvm_rand_send_pri_with(mstr_seq_item, `UVMA_AXIS_MSTR_IDLE_SEQ_ITEM_PRI, {
         tvalid == 0;
      })
   end
   
endtask : mstr


task uvma_axis_idle_vseq_c::slv();
   
    uvma_axis_slv_seq_item_c  slv_seq_item;
   
   forever begin
      `uvm_create_on(slv_seq_item, p_sequencer.slv_sequencer)
      `uvm_rand_send_pri(slv_seq_item, `UVMA_AXIS_SLV_IDLE_SEQ_ITEM_PRI)
   end
   
endtask : slv


`endif // __UVMA_AXIS_IDLE_VSEQ_SV__
