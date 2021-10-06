// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMT_AXIS_ST_TEST_CFG_SV__
`define __UVMT_AXIS_ST_TEST_CFG_SV__


/**
 * Object encapsulating configuration parameters common to most if not all tests
 * extending from uvmt_axis_st_base_test_c.
 */
class uvmt_axis_st_test_cfg_c extends uvm_object;
   
   // Simulation Knobs
   rand int unsigned  clk_period        ; // Specified in picoseconds (ps)
   rand int unsigned  reset_period      ; // Specified in nanoseconds (ns)
   rand int unsigned  startup_timeout   ; // Specified in nanoseconds (ns)
   rand int unsigned  heartbeat_period  ; // Specified in nanoseconds (ns)
   rand int unsigned  simulation_timeout; // Specified in nanoseconds (ns)
   
   // Stimulus Knobs
   rand int unsigned  num_pkts    ;
   rand int unsigned  min_pkt_size;
   rand int unsigned  max_pkt_size;
   rand int unsigned  min_ipg     ;
   rand int unsigned  max_ipg     ;
   rand int unsigned  pct_ton     ;
   
   // Command line arguments
   string        cli_num_pkts_str      = "NPKTS";
   string        cli_min_pkt_size_str  = "MINSZ";
   string        cli_max_pkt_size_str  = "MAXSZ";
   string        cli_min_ipg_str       = "MNIPG";
   string        cli_max_ipg_str       = "MXIPG";
   string        cli_pct_ton_str       = "PCTON";
   bit           cli_num_pkts_override      = 0;
   bit           cli_min_pkt_size_override  = 0;
   bit           cli_max_pkt_size_override  = 0;
   bit           cli_min_ipg_override       = 0;
   bit           cli_max_ipg_override       = 0;
   bit           cli_pct_ton_override       = 0;
   int unsigned  cli_num_pkts_parsed    ;
   int unsigned  cli_min_pkt_size_parsed;
   int unsigned  cli_max_pkt_size_parsed;
   int unsigned  cli_min_ipg_parsed     ;
   int unsigned  cli_max_ipg_parsed     ;
   int unsigned  cli_pct_ton_parsed     ;
   
   
   `uvm_object_utils_begin(uvmt_axis_st_test_cfg_c)
      `uvm_field_int(clk_period        , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(reset_period      , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(startup_timeout   , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(heartbeat_period  , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(simulation_timeout, UVM_DEFAULT + UVM_DEC)
      
      `uvm_field_int(num_pkts    , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_pkt_size, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_pkt_size, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_ipg     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_ipg     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(pct_ton     , UVM_DEFAULT + UVM_DEC)
      
      `uvm_field_string(cli_num_pkts_str         , UVM_DEFAULT)
      `uvm_field_string(cli_min_pkt_size_str     , UVM_DEFAULT)
      `uvm_field_string(cli_max_pkt_size_str     , UVM_DEFAULT)
      `uvm_field_string(cli_min_ipg_str          , UVM_DEFAULT)
      `uvm_field_string(cli_max_ipg_str          , UVM_DEFAULT)
      `uvm_field_string(cli_pct_ton_str          , UVM_DEFAULT)
      `uvm_field_int   (cli_num_pkts_override    , UVM_DEFAULT)
      `uvm_field_int   (cli_min_pkt_size_override, UVM_DEFAULT)
      `uvm_field_int   (cli_max_pkt_size_override, UVM_DEFAULT)
      `uvm_field_int   (cli_min_ipg_override     , UVM_DEFAULT)
      `uvm_field_int   (cli_max_ipg_override     , UVM_DEFAULT)
      `uvm_field_int   (cli_pct_ton_override     , UVM_DEFAULT)
      `uvm_field_int   (cli_num_pkts_parsed      , UVM_DEFAULT)
      `uvm_field_int   (cli_min_pkt_size_parsed  , UVM_DEFAULT)
      `uvm_field_int   (cli_max_pkt_size_parsed  , UVM_DEFAULT)
      `uvm_field_int   (cli_min_ipg_parsed       , UVM_DEFAULT)
      `uvm_field_int   (cli_max_ipg_parsed       , UVM_DEFAULT)
      `uvm_field_int   (cli_pct_ton_parsed       , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      /*soft*/ clk_period         == uvmt_axis_st_default_clk_period        ;
      /*soft*/ reset_period       == uvmt_axis_st_default_reset_period      ;
      /*soft*/ startup_timeout    == uvmt_axis_st_default_startup_timeout   ;
      /*soft*/ heartbeat_period   == uvmt_axis_st_default_heartbeat_period  ;
      /*soft*/ simulation_timeout == uvmt_axis_st_default_simulation_timeout;
   }
   
   
   constraint cli_cons {
      if (cli_num_pkts_override) {
         num_pkts == cli_num_pkts_parsed;
      }
      else {
         /*soft*/ num_pkts == uvmt_axis_st_default_num_pkts;
      }
      
      if (cli_min_pkt_size_override) {
         min_pkt_size == cli_min_pkt_size_parsed;
      }
      else {
         /*soft*/ min_pkt_size == uvmt_axis_st_default_min_pkt_size;
      }
      
      if (cli_max_pkt_size_override) {
         max_pkt_size == cli_max_pkt_size_parsed;
      }
      else {
         /*soft*/ max_pkt_size == uvmt_axis_st_default_max_pkt_size;
      }
      
      if (cli_min_ipg_override) {
         min_ipg == cli_min_ipg_parsed;
      }
      else {
         /*soft*/ min_ipg == uvmt_axis_st_default_min_ipg;
      }
      
      if (cli_max_ipg_override) {
         max_ipg == cli_max_ipg_parsed;
      }
      else {
         /*soft*/ max_ipg == uvmt_axis_st_default_max_ipg;
      }
      
      if (cli_pct_ton_override) {
         pct_ton == cli_pct_ton_parsed;
      }
      else {
         /*soft*/ pct_ton == uvmt_axis_st_default_pct_ton;
      }
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvmt_axis_st_test_cfg");
   
   /**
    * TODO Describe uvmt_axis_st_test_cfg_c::process_cli_args()
    */
   extern function void process_cli_args();
   
endclass : uvmt_axis_st_test_cfg_c


function uvmt_axis_st_test_cfg_c::new(string name="uvmt_axis_st_test_cfg");
   
   super.new(name);
   
endfunction : new


function void uvmt_axis_st_test_cfg_c::process_cli_args();
   
   string  cli_num_pkts_parsed_str      = "";
   string  cli_min_pkt_size_parsed_str  = "";
   string  cli_max_pkt_size_parsed_str  = "";
   string  cli_min_ipg_parsed_str       = "";
   string  cli_max_ipg_parsed_str       = "";
   string  cli_pct_ton_parsed_str       = "";
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_num_pkts_str, "="}, cli_num_pkts_parsed_str)) begin
      if (cli_num_pkts_parsed_str != "") begin
         cli_num_pkts_override = 1;
         cli_num_pkts_parsed = cli_num_pkts_parsed_str.atoi();
      end
      else begin
         cli_num_pkts_override = 0;
      end
   end
   else begin
      cli_num_pkts_override = 0;
   end
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_min_pkt_size_str, "="}, cli_min_pkt_size_parsed_str)) begin
      if (cli_min_pkt_size_parsed_str != "") begin
         cli_min_pkt_size_override = 1;
         cli_min_pkt_size_parsed = cli_min_pkt_size_parsed_str.atoi();
      end
      else begin
         cli_min_pkt_size_override = 0;
      end
   end
   else begin
      cli_min_pkt_size_override = 0;
   end
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_max_pkt_size_str, "="}, cli_max_pkt_size_parsed_str)) begin
      if (cli_max_pkt_size_parsed_str != "") begin
         cli_max_pkt_size_override = 1;
         cli_max_pkt_size_parsed = cli_max_pkt_size_parsed_str.atoi();
      end
      else begin
         cli_max_pkt_size_override = 0;
      end
   end
   else begin
      cli_max_pkt_size_override = 0;
   end
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_min_ipg_str, "="}, cli_min_ipg_parsed_str)) begin
      if (cli_min_ipg_parsed_str != "") begin
         cli_min_ipg_override = 1;
         cli_min_ipg_parsed = cli_min_ipg_parsed_str.atoi();
      end
      else begin
         cli_min_ipg_override = 0;
      end
   end
   else begin
      cli_min_ipg_override = 0;
   end
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_max_ipg_str, "="}, cli_max_ipg_parsed_str)) begin
      if (cli_max_ipg_parsed_str != "") begin
         cli_max_ipg_override = 1;
         cli_max_ipg_parsed = cli_max_ipg_parsed_str.atoi();
      end
      else begin
         cli_max_ipg_override = 0;
      end
   end
   else begin
      cli_max_ipg_override = 0;
   end
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_pct_ton_str, "="}, cli_pct_ton_parsed_str)) begin
      if (cli_pct_ton_parsed_str != "") begin
         cli_pct_ton_override = 1;
         cli_pct_ton_parsed = cli_pct_ton_parsed_str.atoi();
      end
      else begin
         cli_pct_ton_override = 0;
      end
   end
   else begin
      cli_pct_ton_override = 0;
   end
   
endfunction : process_cli_args


`endif // __UVMT_AXIS_ST_TEST_CFG_SV__
