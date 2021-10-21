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


`ifndef __UVMA_AXIS_MSTR_SEQ_ITEM_SV__
`define __UVMA_AXIS_MSTR_SEQ_ITEM_SV__


/**
 * TODO Describe uvma_axis_mstr_seq_item_c
 */
class uvma_axis_mstr_seq_item_c extends uvml_mon_trn_c;
   
   uvma_axis_cfg_c  cfg; ///< 
   
   // Data
   uvma_axis_tvalid_b_t  tvalid; ///< 
   uvma_axis_tdata_b_t   tdata ; ///< 
   uvma_axis_tstrb_b_t   tstrb ; ///< 
   uvma_axis_tkeep_b_t   tkeep ; ///< 
   uvma_axis_tlast_b_t   tlast ; ///< 
   uvma_axis_tid_b_t     tid   ; ///< 
   uvma_axis_tdest_b_t   tdest ; ///< 
   uvma_axis_tuser_b_t   tuser ; ///< 
   
   // Metadata
   
   
   `uvm_object_utils_begin(uvma_axis_mstr_seq_item_c)
      `uvm_field_int(tvalid, UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(tdata , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(tstrb , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(tkeep , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(tlast , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(tid   , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(tdest , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int(tuser , UVM_DEFAULT + UVM_NOPRINT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_mstr_seq_item");
   
   /**
    * TODO Describe uvma_axis_mstr_seq_item_c::do_print()
    */
   extern function void do_print(uvm_printer printer);
   
   /**
    * TODO Describe uvma_axis_mstr_seq_item_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();
   
endclass : uvma_axis_mstr_seq_item_c


function uvma_axis_mstr_seq_item_c::new(string name="uvma_axis_mstr_seq_item");
   
   super.new(name);
   
endfunction : new


function void uvma_axis_mstr_seq_item_c::do_print(uvm_printer printer);
   
   super.do_print(printer);
   
   printer.print_field("tvalid", tlast, $bits(tvalid));
   printer.print_field("tdata" , tdata, cfg.tdata_width*8);
   printer.print_field("tstrb" , tstrb, cfg.tdata_width, UVM_BIN);
   printer.print_field("tkeep" , tkeep, cfg.tkeep_width, UVM_BIN);
   printer.print_field("tlast" , tlast, $bits(tlast));
   
   if (tid_width != 0) begin
      printer.print_field("tid", tid, cfg.tid_width);
   end
   
   if (tdest_width != 0) begin
      printer.print_field("tdest", tdest, cfg.tdest_width);
   end
   
   if (tuser_width != 0) begin
      printer.print_field("tuser", tuser, cfg.tuser_width);
   end
   
endfunction : do_print


function uvml_metadata_t uvma_axis_mstr_seq_item_c::get_metadata();
   
   string tstatus_str = "";
   string tdata_str   = $sformatf($sformatf("%%0dh", cfg.tdata_width*8), tdata);
   string tstrb_str   = $sformatf($sformatf("%%0dh", cfg.tdata_width  ), tstrb);
   string tkeep_str   = $sformatf($sformatf("%%0dh", cfg.tkeep_width  ), tkeep);
   string tid_str     = $sformatf($sformatf("%%0dh", cfg.tid_width    ), tid  );
   string tdest_str   = $sformatf($sformatf("%%0dh", cfg.tdest_width  ), tdest);
   string tuser_str   = $sformatf($sformatf("%%0dh", cfg.tuser_width  ), tuser);
   
   get_metadata[0] = '{
      index     : 0,
      value     : status_str,
      col_name  : "status",
      col_width :  8,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[1] = '{
      index     : 1,
      value     : tid_str,
      col_name  : "tid",
      col_width : 5,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[2] = '{
      index     : 2,
      value     : tdest_str,
      col_name  : "tdest",
      col_width :  7,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[3] = '{
      index     : 3,
      value     : tuser_str,
      col_name  : "tuser",
      col_width :  7,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[4] = '{
      index     : 4,
      value     : tstrb_str,
      col_name  : "tstrb",
      col_width :  7,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[5] = '{
      index     : 5,
      value     : tkeep_str,
      col_name  : "tkeep",
      col_width : 7,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_QUEUE_INT
   };
   
   get_metadata[6] = '{
      index     : 6,
      value     : tdata_str,
      col_name  : "data",
      col_width : 25,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_QUEUE_INT
   };
   
endfunction : get_metadata


`endif // __UVMA_AXIS_MSTR_SEQ_ITEM_SV__
