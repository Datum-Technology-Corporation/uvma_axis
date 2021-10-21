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


`ifndef __UVMA_AXIS_MSTR_SQR_SV__
`define __UVMA_AXIS_MSTR_SQR_SV__


/**
 * Component running AMBA Advanced Extensible Interface Stream sequences extending uvma_axis_seq_base_c.
 * Provides sequence items for uvma_axis_drv_c.
 */
class uvma_axis_mstr_sqr_c extends uvml_sqr_c #(
   .REQ(uvma_axis_mstr_seq_item_c),
   .RSP(uvma_axis_mstr_seq_item_c)
);
   
   // Objects
   uvma_axis_cfg_c    cfg  ; ///< 
   uvma_axis_cntxt_c  cntxt; ///< 
   
   
   `uvm_component_utils_begin(uvma_axis_mstr_sqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_mstr_sqr", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null
    */
   extern virtual function void build_phase(uvm_phase phase);
   
endclass : uvma_axis_mstr_sqr_c


function uvma_axis_mstr_sqr_c::new(string name="uvma_axis_mstr_sqr", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_axis_mstr_sqr_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_axis_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_axis_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
endfunction : build_phase


`endif // __UVMA_AXIS_MSTR_SQR_SV__
