// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_MSTR_OBJECT_SEQ_SV__
`define __UVMA_AXIS_MSTR_OBJECT_SEQ_SV__


/**
 * Base sequence for sequences that use the agent in 'layered' mode: where
 * higher-layer sequence items are fed to the AXIS sequencer (uvma_axis_sqr_c)
 * as payloads.
 */
class uvma_axis_mstr_object_seq_c extends uvma_axis_mstr_base_seq_c;
   
   uvm_object  payload;
   
   
   `uvm_object_utils_begin(uvma_axis_mstr_object_seq_c)
      `uvm_field_object(payload, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_mstr_object_seq");
   
   /**
    * Gets new higher-layer sequence items
    */
   extern virtual task body();
   
endclass : uvma_axis_mstr_object_seq_c


function uvma_axis_mstr_object_seq_c::new(string name="uvma_axis_mstr_object_seq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_mstr_object_seq_c::body();
   
   bit [7:0]  payload_bytes[];
   void'(payload.pack_bytes(payload_bytes));
   
   // Create seq item
   `uvm_do_with(req, {
      req.size == payload_bytes.size();
      foreach (req.data[ii]) {
         req.data[ii] == payload_bytes[ii];
      }
      req.tuser == payload_bytes.size();
   })
   
endtask : body


`endif // __UVMA_AXIS_MSTR_OBJECT_SEQ_SV__
