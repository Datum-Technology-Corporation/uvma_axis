// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_CYCLE_SEQ_ITEM_LOGGER_SV__
`define __UVMA_AXIS_CYCLE_SEQ_ITEM_LOGGER_SV__


/**
 * Component writing AMBA Advanced Extensible Interface Stream sequence items
 * debug data to disk as plain text.
 */
class uvma_axis_cycle_seq_item_logger_c extends uvml_logs_seq_item_logger_c#(
   .T_TRN  (uvma_axis_cycle_seq_item_c),
   .T_CFG  (uvma_axis_cfg_c           ),
   .T_CNTXT(uvma_axis_cntxt_c         )
);
   
   `uvm_component_utils(uvma_axis_cycle_seq_item_logger_c)
   
   
   /**
    * Default constructor.
    */
   function new(string name="uvma_axis_cycle_seq_item_logger", uvm_component parent=null);
      
      super.new(name, parent);
      
   endfunction : new
   
   /**
    * Writes contents of t to disk.
    */
   virtual function void write(uvma_axis_cycle_seq_item_c t);
      
      string     tvalid_str = " ";
      string     tready_str = " ";
      string     tlast_str  = " ";
      string     state_str  = "";
      string     tstrb_str  = "";
      string     tkeep_str  = "";
      string     tid_str    = "";
      string     tdest_str  = "";
      string     tuser_str  = "";
      string     tdata_str  = "";
      bit [7:0]  data[];
      
      // State string
      if (t.tvalid === 1) begin
         tready_str = "V";
      end
      if (t.tready === 1) begin
         tready_str = "R";
      end
      if (t.tlast  === 1) begin
         tlast_str  = "L";
      end
      state_str = {tvalid_str, tready_str, tlast_str};
      
      // Data strings
      tstrb_str = $sformatf($sformatf("%%0db", t.tdata.size()), t.tstrb);
      tkeep_str = $sformatf($sformatf("%%0db", t.tdata.size()), t.tkeep);
      tid_str   = $sformatf($sformatf("%%0dh", t.tid_width   ), t.tid  );
      tdest_str = $sformatf($sformatf("%%0dh", t.tdest_width ), t.tdest);
      tuser_str = $sformatf($sformatf("%%0dh", t.tuser_width ), t.tuser);
      data = new[t.tdata.size()];
      foreach (data[ii]) begin
         data[ii] = t.tdata[ii];
      end
      tdata_str = log_bytes(data);
      
      fwrite($sformatf(" %t |  %s  |  %s  | %s | %s | %s | %s | %s",
         $realtime(), state_str, tstrb_str, tkeep_str, tid_str, tdest_str, tuser_str, tdata_str)
      );
      
   endfunction : write
   
   /**
    * Writes log header to disk.
    */
   virtual function void print_header();
      
      fwrite("LEGEND:");
      fwrite("   V: TVALID is '1'");
      fwrite("   R: TREADY is '1'");
      fwrite("   L: TLAST  is '1'");
      fwrite("");
      
      fwrite("------------------------------------------------------------");
      fwrite("     TIME     | STATE | TSTRB | TKEEP | TID | TDEST | TUSER | TDATA");
      fwrite("------------------------------------------------------------");
      
   endfunction : print_header
   
endclass : uvma_axis_cycle_seq_item_logger_c


/**
 * Component writing AMBA Advanced Extensible Interface Stream monitor transactions debug data to disk as JavaScript Object Notation (JSON).
 */
class uvma_axis_cycle_seq_item_logger_json_c extends uvma_axis_cycle_seq_item_logger_c;
   
   `uvm_component_utils(uvma_axis_cycle_seq_item_logger_json_c)
   
   
   /**
    * Set file extension to '.json'.
    */
   function new(string name="uvma_axis_cycle_seq_item_logger_json", uvm_component parent=null);
      
      super.new(name, parent);
      fextension = "json";
      
   endfunction : new
   
   /**
    * Writes contents of t to disk.
    */
   virtual function void write(uvma_axis_cycle_seq_item_c t);
      
      // TODO Implement uvma_axis_cycle_seq_item_logger_json_c::write()
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
   
endclass : uvma_axis_cycle_seq_item_logger_json_c


`endif // __UVMA_AXIS_CYCLE_SEQ_ITEM_LOGGER_SV__
