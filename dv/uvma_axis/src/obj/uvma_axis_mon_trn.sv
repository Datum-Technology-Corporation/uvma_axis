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


`ifndef __UVMA_AXIS_MON_TRN_SV__
`define __UVMA_AXIS_MON_TRN_SV__


/**
 * Object rebuilt from the AMBA Advanced Extensible Interface Stream monitor.  Analog of uvma_axis_mon_trn_c.
 */
class uvma_axis_mon_trn_c extends uvml_mon_trn_c;
   
   uvma_axis_cfg_c  cfg; ///< 
   
   // Data
   int unsigned               size   ; ///< 
   logic [7:0]                data[$]; ///< 
   logic uvma_axis_tid_l_t    tid    ; ///< 
   logic uvma_axis_tdest_l_t  tdest  ; ///< 
   logic uvma_axis_tuser_l_t  tuser  ; ///< 
   logic uvma_axis_tkeep_l_t  tkeep  ; ///< 
   
   // Metadata
   
   
   `uvm_object_utils_begin(uvma_axis_mon_trn_c)
      `uvm_field_int      (size , UVM_DEFAULT + UVM_DEC    )
      `uvm_field_queue_int(data , UVM_DEFAULT              )
      `uvm_field_int      (tid  , UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int      (tdest, UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int      (tuser, UVM_DEFAULT + UVM_NOPRINT)
      `uvm_field_int      (tkeep, UVM_DEFAULT + UVM_NOPRINT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_mon_trn");
   
   /**
    * TODO Describe uvma_axis_mon_trn_c::do_print()
    */
   extern virtual function void do_print(uvm_printer printer);
   
   /**
    * TODO Describe uvma_axis_mon_trn_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();
   
   /**
    * Returns string of byte array in 'xxxx_xxxx' format.
    */
   extern function string log_bytes(ref bit [7:0] bytes[]);
   
endclass : uvma_axis_mon_trn_c


function uvma_axis_mon_trn_c::new(string name="uvma_axis_mon_trn");
   
   super.new(name);
   
endfunction : new


function void uvma_axis_mon_trn_c::do_print(uvm_printer printer);
   
   super.do_print(printer);
   
   if (tid_width != 0) begin
      printer.print_field("tid", tid, cfg.tid_width);
   end
   
   if (tdest_width != 0) begin
      printer.print_field("tdest", tdest, cfg.tdest_width);
   end
   
   if (tuser_width != 0) begin
      printer.print_field("tuser", tuser, cfg.tuser_width);
   end
   
   if (tkeep_width != 0) begin
      printer.print_field("tkeep", tkeep, cfg.tkeep_width);
   end
   
endfunction : do_print


function uvml_metadata_t uvma_axis_mon_trn_c::get_metadata();
   
   string data_str  = "";
   string size_str  = $sformatf("%d", size);
   string tid_str   = $sformatf($sformatf("%%0dh", cfg.tid_width  ), tid  );
   string tdest_str = $sformatf($sformatf("%%0dh", cfg.tdest_width), tdest);
   string tuser_str = $sformatf($sformatf("%%0dh", cfg.tuser_width), tuser);
   string tkeep_str = $sformatf($sformatf("%%0dh", cfg.tkeep_width), tkeep);
   
   bit [7:0]  lower_n_bytes[];
   bit [7:0]  upper_n_bytes[];
   
   if (size > (uvma_axis_logging_num_data_bytes*2)) begin
      // Log first n bytes and last n bytes
      lower_n_bytes = new[uvma_axis_logging_num_data_bytes];
      foreach (lower_n_bytes[ii]) begin
         lower_n_bytes[ii] = data[ii];
      end
      upper_n_bytes = new[uvma_axis_logging_num_data_bytes];
      foreach (upper_n_bytes[ii]) begin
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
      col_width :  6,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[1] = '{
      index     : 1,
      value     : tdest_str,
      col_name  : "tdest",
      col_width : 7,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[2] = '{
      index     : 2,
      value     : tuser_str,
      col_name  : "tuser",
      col_width :  7,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[3] = '{
      index     : 3,
      value     : size_str,
      col_name  : "size",
      col_width :  6,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[4] = '{
      index     : 4,
      value     : tkeep_str,
      col_name  : "tkeep",
      col_width :  7,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_INT
   };
   
   get_metadata[5] = '{
      index     : 5,
      value     : data_str,
      col_name  : "data",
      col_width : 25,
      col_align : UVML_TEXT_ALIGN_RIGHT,
      data_type : UVML_FIELD_QUEUE_INT
   };
   
endfunction : get_metadata


function string uvma_axis_mon_trn_c::log_bytes(ref bit [7:0] bytes[]);
   
   foreach (bytes[ii]) begin
      log_bytes = {$sformatf("%h", bytes[ii]), log_bytes};
      if ((ii % 2) && (ii != (bytes.size()-1))) begin
         log_bytes = {"_", log_bytes};
      end
   end
   
endfunction : log_bytes


`endif // __UVMA_AXIS_MON_TRN_SV__
