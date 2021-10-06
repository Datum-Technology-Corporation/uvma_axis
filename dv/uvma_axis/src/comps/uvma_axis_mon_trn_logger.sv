// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_MON_TRN_LOGGER_SV__
`define __UVMA_AXIS_MON_TRN_LOGGER_SV__


/**
 * Component writing AMBA Advanced Extensible Interface Stream monitor transactions debug data to disk as plain text.
 */
class uvma_axis_mon_trn_logger_c extends uvml_logs_mon_trn_logger_c#(
   .T_TRN  (uvma_axis_mon_trn_c),
   .T_CFG  (uvma_axis_cfg_c    ),
   .T_CNTXT(uvma_axis_cntxt_c  )
);
   
   `uvm_component_utils(uvma_axis_mon_trn_logger_c)
   
   
   /**
    * Default constructor.
    */
   function new(string name="uvma_axis_mon_trn_logger", uvm_component parent=null);
      
      super.new(name, parent);
      
   endfunction : new
   
   /**
    * Writes contents of t to disk
    */
   virtual function void write(uvma_axis_mon_trn_c t);
      
      string  tid_str    = "";
      string  tdest_str  = "";
      string  tuser_str  = "";
      string  data_str   = "";
      
      logic [7:0]  lower_n_bytes[];
      logic [7:0]  upper_n_bytes[];
      
      if (t.size > (uvma_axis_logging_num_data_bytes*2)) begin
         // Log first n bytes and last n bytes
         lower_n_bytes = new[uvma_axis_logging_num_data_bytes];
         foreach (lower_n_bytes[ii]) begin
            lower_n_bytes[ii] = t.data[ii];
         end
         upper_n_bytes = new[uvma_axis_logging_num_data_bytes];
         foreach (upper_n_bytes[ii]) begin
            upper_n_bytes[ii] = t.data[(t.size - uvma_axis_logging_num_data_bytes) + ii];
         end
         data_str = {log_bytes(upper_n_bytes), " ... ", log_bytes(lower_n_bytes)};
      end
      else begin
         // Log all data bytes
         data_str = log_bytes(t.data);
      end
      
      tid_str   = $sformatf($sformatf("%%0dh", t.tid_width  ), t.tid  );
      tdest_str = $sformatf($sformatf("%%0dh", t.tdest_width), t.tdest);
      tuser_str = $sformatf($sformatf("%%0dh", t.tuser_width), t.tuser);
      
      fwrite($sformatf("   %t   | %08dB | %s | %s", $realtime(), t.size, tid_str, tdest_str, tuser_str, data_str));
      
   endfunction : write
   
   /**
    * Writes log header to disk
    */
   virtual function void print_header();
      
      fwrite("-------------------------------------------------");
      fwrite("     TIME     | SIZE | TID | TDEST | TUSER | DATA");
      fwrite("-------------------------------------------------");
      
   endfunction : print_header
   
endclass : uvma_axis_mon_trn_logger_c


/**
 * Component writing AXIS monitor transactions debug data to disk as JavaScript Object Notation (JSON).
 */
class uvma_axis_mon_trn_logger_json_c extends uvma_axis_mon_trn_logger_c;
   
   `uvm_component_utils(uvma_axis_mon_trn_logger_json_c)
   
   
   /**
    * Set file extension to '.json'.
    */
   function new(string name="uvma_axis_mon_trn_logger_json", uvm_component parent=null);
      
      super.new(name, parent);
      fextension = "json";
      
   endfunction : new
   
   /**
    * Writes contents of t to disk.
    */
   virtual function void write(uvma_axis_mon_trn_c t);
      
      // TODO Implement uvma_axis_mon_trn_logger_json_c::write()
      // Ex: fwrite({"{",
      //       $sformatf("\"time\":\"%0t\",", $realtime()),
      //       $sformatf("\"a\":%h,"        , t.a        ),
      //       $sformatf("\"b\":%b,"        , t.b        ),
      //       $sformatf("\"c\":%d,"        , t.c        ),
      //       $sformatf("\"d\":%h,"        , t.c        ),
      //     "},"});
      
   endfunction : write
   
   /**
    * Empty function.
    */
   virtual function void print_header();
      
      // Do nothing: JSON files do not use headers.
      
   endfunction : print_header
   
endclass : uvma_axis_mon_trn_logger_json_c


`endif // __UVMA_AXIS_MON_TRN_LOGGER_SV__
