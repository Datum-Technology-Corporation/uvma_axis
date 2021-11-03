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


`ifndef __UVMA_AXIS_MSTR_MON_TRN_SV__
`define __UVMA_AXIS_MSTR_MON_TRN_SV__


/**
 * TODO Describe uvma_axis_mstr_mon_trn_c
 */
class uvma_axis_mstr_mon_trn_c extends uvml_mon_trn_c;
   
   uvma_axis_cfg_c  cfg; ///< 
   
   // Data
   uvma_axis_tvalid_l_t  tvalid; ///< 
   uvma_axis_tdata_l_t   tdata ; ///< 
   uvma_axis_tstrb_l_t   tstrb ; ///< 
   uvma_axis_tkeep_l_t   tkeep ; ///< 
   uvma_axis_tlast_l_t   tlast ; ///< 
   uvma_axis_tid_l_t     tid   ; ///< 
   uvma_axis_tdest_l_t   tdest ; ///< 
   uvma_axis_tuser_l_t   tuser ; ///< 
   
   // Metadata
   bit  data_transferred;
   
   
   `uvm_object_utils_begin(uvma_axis_mstr_mon_trn_c)
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
   extern function new(string name="uvma_axis_mstr_mon_trn");
   
   /**
    * TODO Describe uvma_axis_mstr_mon_trn_c::do_print()
    */
   extern function void do_print(uvm_printer printer);
   
   /**
    * TODO Describe uvma_axis_mstr_mon_trn_c::get_metadata()
    */
   extern function uvml_metadata_t get_metadata();
   
endclass : uvma_axis_mstr_mon_trn_c


function uvma_axis_mstr_mon_trn_c::new(string name="uvma_axis_mstr_mon_trn");
   
   super.new(name);
   data_transferred = 0;
   
endfunction : new


function void uvma_axis_mstr_mon_trn_c::do_print(uvm_printer printer);
   
   super.do_print(printer);
   
   if (cfg != null) begin
      printer.print_field("tvalid", tvalid, $bits(tvalid));
      printer.print_field("tdata" , tdata , cfg.tdata_width*8);
      printer.print_field("tstrb" , tstrb , cfg.tdata_width);
      printer.print_field("tkeep" , tkeep , cfg.tdata_width);
      printer.print_field("tlast" , tlast , $bits(tlast));
      
      if (cfg.tid_width != 0) begin
         printer.print_field("tid", tid, cfg.tid_width);
      end
      
      if (cfg.tdest_width != 0) begin
         printer.print_field("tdest", tdest, cfg.tdest_width);
      end
      
      if (cfg.tuser_width != 0) begin
         printer.print_field("tuser", tuser, cfg.tuser_width);
      end
   end
   
endfunction : do_print


function uvml_metadata_t uvma_axis_mstr_mon_trn_c::get_metadata();
   
   string status_str = "";
   string tdata_str  = "";
   string tstrb_str  = $sformatf("%h", tstrb);
   string tkeep_str  = $sformatf("%h", tkeep);
   string tid_str    = $sformatf("%h", tid  );
   string tdest_str  = $sformatf("%h", tdest);
   string tuser_str  = $sformatf("%h", tuser);
   
   if (data_transferred && (cfg != null)) begin
      foreach (tdata[ii]) begin
         if (ii < cfg.tdata_width) begin
            tdata_str = {tdata_str, $sformatf("%h", tdata[ii])};
         end
      end
      
      tstrb_str = tstrb_str.substr(tstrb_str.len() - (cfg.tdata_width/4), tstrb_str.len()-1);
      tkeep_str = tkeep_str.substr(tkeep_str.len() - (cfg.tdata_width/4), tkeep_str.len()-1);
      tid_str   = tid_str  .substr(tid_str  .len() - (cfg.tid_width  /4), tid_str  .len()-1);
      tdest_str = tdest_str.substr(tdest_str.len() - (cfg.tdest_width/4), tdest_str.len()-1);
      tuser_str = tuser_str.substr(tuser_str.len() - (cfg.tuser_width/4), tuser_str.len()-1);
      
      if (tvalid === 1'b1) begin
         status_str = "V";
         if (tlast === 1'b1) begin
            status_str = {status_str, "L"};
         end
         
         get_metadata[0] = '{
            index     : 0,
            value     : status_str,
            col_name  : "status",
            col_width :  6,
            col_align : UVML_TEXT_ALIGN_RIGHT,
            data_type : UVML_FIELD_INT
         };
         
         get_metadata[1] = '{
            index     : 1,
            value     : tid_str,
            col_name  : "tid",
            col_width : cfg.tid_width/4,
            col_align : UVML_TEXT_ALIGN_RIGHT,
            data_type : UVML_FIELD_INT
         };
         
         get_metadata[2] = '{
            index     : 2,
            value     : tdest_str,
            col_name  : "tdest",
            col_width : cfg.tdest_width/4,
            col_align : UVML_TEXT_ALIGN_RIGHT,
            data_type : UVML_FIELD_INT
         };
         
         get_metadata[3] = '{
            index     : 3,
            value     : tuser_str,
            col_name  : "tuser",
            col_width : cfg.tuser_width/4,
            col_align : UVML_TEXT_ALIGN_RIGHT,
            data_type : UVML_FIELD_INT
         };
         
         get_metadata[4] = '{
            index     : 4,
            value     : tstrb_str,
            col_name  : "tstrb",
            col_width : cfg.tdata_width/4,
            col_align : UVML_TEXT_ALIGN_RIGHT,
            data_type : UVML_FIELD_INT
         };
         
         get_metadata[5] = '{
            index     : 5,
            value     : tkeep_str,
            col_name  : "tkeep",
            col_width : cfg.tdata_width/4,
            col_align : UVML_TEXT_ALIGN_RIGHT,
            data_type : UVML_FIELD_QUEUE_INT
         };
         
         get_metadata[6] = '{
            index     : 6,
            value     : tdata_str,
            col_name  : "data",
            col_width : cfg.tdata_width*2,
            col_align : UVML_TEXT_ALIGN_RIGHT,
            data_type : UVML_FIELD_QUEUE_INT
         };
      end
   end
   
endfunction : get_metadata


`endif // __UVMA_AXIS_MSTR_MON_TRN_SV__
