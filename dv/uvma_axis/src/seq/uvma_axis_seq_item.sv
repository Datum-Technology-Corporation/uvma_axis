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


`ifndef __UVMA_AXIS_SEQ_ITEM_SV__
`define __UVMA_AXIS_SEQ_ITEM_SV__


/**
 * TODO Describe uvma_axis_seq_item_c
 */
class uvma_axis_seq_item_c extends uvml_seq_item_c;
   
   uvma_axis_cfg_c  cfg; ///< 
   
   // Data
   rand int unsigned         size  ; ///< 
   rand bit [7:0]            data[]; ///< 
   rand uvma_axis_tid_b_t    tid   ; ///< 
   rand uvma_axis_tdest_b_t  tdest ; ///< 
   rand uvma_axis_tuser_b_t  tuser ; ///< 
   rand uvma_axis_tkeep_b_t  tkeep ; ///< 
   
   // Metadata
   rand uvma_axis_data_pattern_enum  pattern; ///< 
   
   
   `uvm_object_utils_begin(uvma_axis_seq_item_c)
      `uvm_field_int      (size , UVM_DEFAULT + UVM_DEC    )
      `uvm_field_array_int(data , UVM_DEFAULT              )
      `uvm_field_int      (tid  , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int      (tdest, UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int      (tuser, UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int      (tkeep, UVM_DEFAULT + UVM_NOPRINT)
      
      `uvm_field_enum(uvma_axis_data_pattern_enum, pattern, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft pattern == UVMA_AXIS_DATA_PATTERN_COUNTING;
   }
   
   constraint limits_cons {
      size < `UVM_PACKER_MAX_BYTES;
      data.size() == size;
      size < `UVM_PACKER_MAX_BYTES;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_seq_item");
   
   /**
    * TODO Describe uvma_axis_seq_item_c::post_randomize()
    */
   extern function void post_randomize();
   
   /**
    * TODO Describe uvma_axis_seq_item_c::do_print()
    */
   extern virtual function void do_print(uvm_printer printer);
   
   /**
    * TODO Describe uvma_axis_seq_item_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();
   
   /**
    * Returns string of byte array in 'xxxx_xxxx' format.
    */
   extern function string log_bytes(ref bit [7:0] bytes[]);
   
endclass : uvma_axis_seq_item_c


function uvma_axis_seq_item_c::new(string name="uvma_axis_seq_item");
   
   super.new(name);
   
endfunction : new


function void uvma_axis_seq_item_c::post_randomize();
   
   foreach (data[ii]) begin
      case (pattern)
         UVMA_AXIS_DATA_PATTERN_COUNTING: data[ii] = ii[7:0];
         UVMA_AXIS_DATA_PATTERN_ZEROS   : data[ii] =      '0;
         UVMA_AXIS_DATA_PATTERN_AAAA    : data[ii] =   8'hAA;
         UVMA_AXIS_DATA_PATTERN_5555    : data[ii] =   8'h55;
      endcase
   end
   
endfunction : post_randomize


function void uvma_axis_seq_item_c::do_print(uvm_printer printer);
   
   super.do_print(printer);
   
   if (cfg.tid_width != 0) begin
      printer.print_field("tid", tid, cfg.tid_width);
   end
   
   if (cfg.tdest_width != 0) begin
      printer.print_field("tdest", tdest, cfg.tdest_width);
   end
   
   if (cfg.tuser_width != 0) begin
      printer.print_field("tuser", tuser, cfg.tuser_width);
   end
   
   if (cfg.tdata_width != 0) begin
      printer.print_field("tkeep", tkeep, cfg.tdata_width);
   end
   
endfunction : do_print


function uvml_metadata_t uvma_axis_seq_item_c::get_metadata();
   
   bit [7:0]  lower_n_bytes[];
   bit [7:0]  upper_n_bytes[];
   string     data_str   = "";
   string     size_str   = $sformatf("%0d", size );
   string     tkeep_str  = $sformatf("%h" , tkeep);
   string     tid_str    = $sformatf("%h" , tid  );
   string     tdest_str  = $sformatf("%h" , tdest);
   string     tuser_str  = $sformatf("%h" , tuser);
   
   tkeep_str = tkeep_str.substr(tkeep_str.len() - (cfg.tdata_width/4), tkeep_str.len()-1);
   tid_str   = tid_str  .substr(tid_str  .len() - (cfg.tid_width  /4), tid_str  .len()-1);
   tdest_str = tdest_str.substr(tdest_str.len() - (cfg.tdest_width/4), tdest_str.len()-1);
   tuser_str = tuser_str.substr(tuser_str.len() - (cfg.tuser_width/4), tuser_str.len()-1);
   
   if (size > (uvma_axis_logging_num_data_bytes*2)) begin
      // Log first n bytes and last n bytes
      lower_n_bytes = new[uvma_axis_logging_num_data_bytes];
      for (int unsigned ii=0; ii<uvma_axis_logging_num_data_bytes; ii++) begin
         lower_n_bytes[ii] = data[ii];
      end
      upper_n_bytes = new[uvma_axis_logging_num_data_bytes];
      for (int unsigned ii=0; ii<uvma_axis_logging_num_data_bytes; ii++) begin
         upper_n_bytes[ii] = data[(size - uvma_axis_logging_num_data_bytes) + ii];
      end
      data_str = {log_bytes(upper_n_bytes), " ... ", log_bytes(lower_n_bytes)};
   end
   else begin
      // Log all data bytes
      data_str = log_bytes(data);
   end
   
   get_metadata[0] = '{
      index     : 0,
      value     : tid_str,
      col_name  : "tid",
      col_width : cfg.tid_width/4,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[1] = '{
      index     : 1,
      value     : tdest_str,
      col_name  : "tdest",
      col_width : cfg.tdest_width/4,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[2] = '{
      index     : 2,
      value     : tuser_str,
      col_name  : "tuser",
      col_width : cfg.tuser_width/4,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[3] = '{
      index     : 3,
      value     : size_str,
      col_name  : "size",
      col_width : 4,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[4] = '{
      index     : 4,
      value     : tkeep_str,
      col_name  : "tkeep",
      col_width : cfg.tdata_width/4,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[5] = '{
      index     : 5,
      value     : data_str,
      col_name  : "data",
      col_width : uvma_axis_logging_num_data_bytes*3*2,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_QUEUE_INT
   };
   
endfunction : get_metadata


function string uvma_axis_seq_item_c::log_bytes(ref bit [7:0] bytes[]);
   
   foreach (bytes[ii]) begin
      log_bytes = {$sformatf("%h", bytes[ii]), log_bytes};
      if ((ii % 2) && (ii != (bytes.size()-1))) begin
         log_bytes = {"_", log_bytes};
      end
   end
   
endfunction : log_bytes


`endif // __UVMA_AXIS_SEQ_ITEM_SV__
