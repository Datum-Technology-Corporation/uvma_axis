// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
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
   uvma_axis_tvalid_l_t  tvalid; ///< 
   
   
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
   extern function uvml_metadata_t get_metadata();
   
endclass : uvma_axis_slv_seq_item_c


function uvma_axis_slv_seq_item_c::new(string name="uvma_axis_slv_seq_item");
   
   super.new(name);
   
endfunction : new


function uvml_metadata_t uvma_axis_slv_seq_item_c::get_metadata();
   
   string tready_str = "";
   
   if ((tvalid === 1'b1) && (tready === 1'b1)) begin
      tready_str = "ASSERTED";
      get_metadata[0] = '{
         index     : 0,
         value     : tready_str,
         col_name  : "tready",
         col_width : 10,
         col_align : UVML_TEXT_ALIGN_RIGHT,
         data_type : UVML_FIELD_INT
      };
   end
   
endfunction : get_metadata


`endif // __UVMA_AXIS_SLV_SEQ_ITEM_SV__
