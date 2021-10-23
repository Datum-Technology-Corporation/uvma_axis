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


`ifndef __UVMA_AXIS_SLV_SEQ_ITEM_SV__
`define __UVMA_AXIS_SLV_SEQ_ITEM_SV__


/**
 * TODO Describe uvma_axis_slv_seq_item_c
 */
class uvma_axis_slv_seq_item_c extends uvml_seq_item_c;
   
   uvma_axis_cfg_c  cfg; ///< 
   
   // Data
   rand uvma_axis_tready_b_t  tready; ///< 
   
   // Metadata
   
   
   `uvm_object_utils_begin(uvma_axis_slv_seq_item_c)
      `uvm_field_int(tready, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_slv_seq_item");
   
   /**
    * TODO Describe uvma_axis_slv_seq_item_c::get_metadata()
    */
   //extern function uvml_metadata_t get_metadata();
   
endclass : uvma_axis_slv_seq_item_c


function uvma_axis_slv_seq_item_c::new(string name="uvma_axis_slv_seq_item");
   
   super.new(name);
   
endfunction : new


//function uvml_metadata_t uvma_axis_slv_seq_item_c::get_metadata();
//   
//   string tready_str = "";
//   
//   if (tready === 1'b1) begin
//      tready_str = "ASSERTED";
//   end
//   
//   get_metadata[0] = '{
//      index     : 0,
//      value     : tready_str,
//      col_name  : "tready",
//      col_width : 10,
//      col_align : UVML_TEXT_ALIGN_RIGHT,
//      data_type : UVML_FIELD_INT
//   };
//   
//endfunction : get_metadata


`endif // __UVMA_AXIS_SLV_SEQ_ITEM_SV__
