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


`ifndef __UVMA_AXIS_MSTR_BASE_VSEQ_SV__
`define __UVMA_AXIS_MSTR_BASE_VSEQ_SV__


/**
 * TODO Describe uvma_axis_mstr_base_vseq_c
 */
class uvma_axis_mstr_base_vseq_c extends uvma_axis_base_vseq_c;
   
   `uvm_object_utils(uvma_axis_mstr_base_vseq_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_mstr_base_vseq");
   
   /**
    * TODO Describe uvma_axis_mstr_base_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_axis_mstr_base_vseq_c::process_req()
    */
   extern function void process_req(ref uvma_axis_seq_item_c seq_item);
   
   /**
    * TODO Describe uvma_axis_mstr_base_vseq_c::drv()
    */
   extern virtual task drv(ref uvma_axis_seq_item_c seq_item);
   
endclass : uvma_axis_mstr_base_vseq_c


function uvma_axis_mstr_base_vseq_c::new(string name="uvma_axis_mstr_base_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_mstr_base_vseq_c::body();
   
   uvma_axis_seq_item_c  seq_item;
   
   forever begin
      fork
         begin
            `uvm_info("AXIS_MSTR_DRV_VSEQ", "Waiting for post_reset", UVM_DEBUG)
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET) begin
               `uvm_info("AXIS_MSTR_DRV_VSEQ", "Waiting for next item", UVM_DEBUG)
               p_sequencer.get_next_item    (seq_item);
               process_req                  (seq_item);
               drv                          (seq_item);
               p_sequencer.seq_item_ap.write(seq_item);
               p_sequencer.item_done();
            end
         end
         
         begin
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            wait (cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
         end
      join_any
      disable fork;
   end
   
endtask : body


function void uvma_axis_mstr_base_vseq_c::process_req(ref uvma_axis_seq_item_c seq_item);
   
   seq_item.cfg = cfg;
   `uvm_info("AXIS_MSTR_DRV_VSEQ", $sformatf("Got item:\n%s", seq_item.sprint()), UVM_HIGH)
   `uvml_hrtbt_owner(p_sequencer)
   
endfunction : process_req


task uvma_axis_mstr_base_vseq_c::drv(ref uvma_axis_seq_item_c seq_item);
   
   
   
endtask : drv


`endif // __UVMA_AXIS_MSTR_BASE_VSEQ_SV__
