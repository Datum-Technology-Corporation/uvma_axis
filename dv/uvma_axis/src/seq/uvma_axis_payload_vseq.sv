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


`ifndef __UVMA_AXIS_PAYLOAD_VSEQ_SV__
`define __UVMA_AXIS_PAYLOAD_VSEQ_SV__


/**
 * TODO Describe uvma_axis_payload_vseq_c
 */
class uvma_axis_payload_vseq_c extends uvma_axis_base_vseq_c;
   
   rand uvma_axis_tid_b_t    tid    ; ///< 
   rand uvma_axis_tdest_b_t  tdest  ; ///< 
   rand uvma_axis_tuser_b_t  tuser  ; ///< 
   
   
   `uvm_object_utils_begin(uvma_axis_payload_vseq_c)
      `uvm_field_object(payload, UVM_DEFAULT)
      `uvm_field_int   (tid    , UVM_DEFAULT)
      `uvm_field_int   (tdest  , UVM_DEFAULT)
      `uvm_field_int   (tuser  , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_payload_vseq");
   
   /**
    * Gets new higher-layer sequence items
    */
   extern virtual task body();
   
endclass : uvma_axis_payload_vseq_c


function uvma_axis_payload_vseq_c::new(string name="uvma_axis_payload_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_payload_vseq_c::body();
   
   uvm_sequence_item  payload;
   bit [7:0]          payload_bytes[];
   
   forever begin
      upstream_get_next_item(payload);
      void'(payload.pack_bytes(payload_bytes));
      
      // Create seq item
      `uvm_do_with(req, {
         req.size == payload_bytes.size();
         foreach (req.data[ii]) {
            req.data[ii] == payload_bytes[ii];
         }
         req.tid   == local::tid  ;
         req.tdest == local::tdest;
         req.tuser == local::tuser;
         req.tkeep == payload_bytes.size()%cfg.tdata_width;
      })
      upstream_item_done(payload);
   end
   
endtask : body


`endif // __UVMA_AXIS_PAYLOAD_VSEQ_SV__
