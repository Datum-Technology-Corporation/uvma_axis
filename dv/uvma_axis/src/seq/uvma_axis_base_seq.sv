// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_BASE_SEQ_SV__
`define __UVMA_AXIS_BASE_SEQ_SV__


/**
 * Abstract object from which all other AMBA Advanced Extensible Interface Stream agent sequences must extend.
 * Subclasses must be run on AMBA Advanced Extensible Interface Stream sequencer (uvma_axis_sqr_c) instance.
 */
class uvma_axis_base_seq_c extends uvm_sequence#(
   .REQ(uvma_axis_seq_item_c),
   .RSP(uvma_axis_seq_item_c)
);
   
   // Agent handles
   uvma_axis_cfg_c    cfg;
   uvma_axis_cntxt_c  cntxt;
   
   
   `uvm_object_utils(uvma_axis_base_seq_c)
   `uvm_declare_p_sequencer(uvma_axis_sqr_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_base_seq");
   
   /**
    * Retrieve cfg and cntxt handles from p_sequencer.
    */
   extern virtual task pre_start();
   
   /**
    * Assigns cfg and cntxt handles from p_sequencer.
    */
   extern virtual task finish_item(uvm_sequence_item item, int set_priority=-1);
   
endclass : uvma_axis_base_seq_c


function uvma_axis_base_seq_c::new(string name="uvma_axis_base_seq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_base_seq_c::pre_start();
   
   cfg   = p_sequencer.cfg;
   cntxt = p_sequencer.cntxt;
   
endtask : pre_start


task uvma_axis_base_seq_c::finish_item(uvm_sequence_item item, int set_priority=-1);
   
   uvma_axis_seq_item_c  _item;
   
   super.finish_item(item, set_priority);
   
   if (!$cast(_item, item)) begin
      `uvm_fatal("AXIS_SEQ", $sformatf("Could not cast 'item' (%s) to '_item' (%s)", $typename(item), $typename(_item)))
   end
   p_sequencer.ap.write(_item);
   
endtask : finish_item


`endif // __UVMA_AXIS_BASE_SEQ_SV__
