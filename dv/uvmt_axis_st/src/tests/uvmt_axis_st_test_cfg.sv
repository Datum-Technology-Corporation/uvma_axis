// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_AXIS_ST_TEST_CFG_SV__
`define __UVMT_AXIS_ST_TEST_CFG_SV__


/**
 * Object encapsulating configuration parameters common to most if not all tests extending from
 * uvmt_axis_st_base_test_c.
 */
class uvmt_axis_st_test_cfg_c extends uvml_test_cfg_c;
   
   // Simulation Knobs
   rand int unsigned  clk_period        ; // Specified in picoseconds (ps)
   rand int unsigned  reset_period      ; // Specified in nanoseconds (ns)
   rand int unsigned  startup_timeout   ; // Specified in nanoseconds (ns)
   rand int unsigned  heartbeat_period  ; // Specified in nanoseconds (ns)
   rand int unsigned  simulation_timeout; // Specified in nanoseconds (ns)
   
   // Stimulus Knobs
   rand int unsigned  num_transfers    ;
   rand int unsigned  min_transfer_size;
   rand int unsigned  max_transfer_size;
   rand int unsigned  min_gap     ;
   rand int unsigned  max_gap     ;
   rand int unsigned  pct_ton     ;
   
   // Command line arguments
   string        cli_num_transfers_str      = "NPKTS";
   string        cli_min_transfer_size_str  = "MINSZ";
   string        cli_max_transfer_size_str  = "MAXSZ";
   string        cli_min_gap_str       = "MNIPG";
   string        cli_max_gap_str       = "MXIPG";
   string        cli_pct_ton_str       = "PCTON";
   bit           cli_num_transfers_override      = 0;
   bit           cli_min_transfer_size_override  = 0;
   bit           cli_max_transfer_size_override  = 0;
   bit           cli_min_gap_override       = 0;
   bit           cli_max_gap_override       = 0;
   bit           cli_pct_ton_override       = 0;
   int unsigned  cli_num_transfers_parsed    ;
   int unsigned  cli_min_transfer_size_parsed;
   int unsigned  cli_max_transfer_size_parsed;
   int unsigned  cli_min_gap_parsed     ;
   int unsigned  cli_max_gap_parsed     ;
   int unsigned  cli_pct_ton_parsed     ;
   
   
   `uvm_object_utils_begin(uvmt_axis_st_test_cfg_c)
      `uvm_field_int(clk_period        , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(reset_period      , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(startup_timeout   , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(heartbeat_period  , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(simulation_timeout, UVM_DEFAULT + UVM_DEC)
      
      `uvm_field_int(num_transfers    , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_transfer_size, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_transfer_size, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_gap     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_gap     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(pct_ton     , UVM_DEFAULT + UVM_DEC)
      
      `uvm_field_string(cli_num_transfers_str         , UVM_DEFAULT)
      `uvm_field_string(cli_min_transfer_size_str     , UVM_DEFAULT)
      `uvm_field_string(cli_max_transfer_size_str     , UVM_DEFAULT)
      `uvm_field_string(cli_min_gap_str          , UVM_DEFAULT)
      `uvm_field_string(cli_max_gap_str          , UVM_DEFAULT)
      `uvm_field_string(cli_pct_ton_str          , UVM_DEFAULT)
      `uvm_field_int   (cli_num_transfers_override    , UVM_DEFAULT)
      `uvm_field_int   (cli_min_transfer_size_override, UVM_DEFAULT)
      `uvm_field_int   (cli_max_transfer_size_override, UVM_DEFAULT)
      `uvm_field_int   (cli_min_gap_override     , UVM_DEFAULT)
      `uvm_field_int   (cli_max_gap_override     , UVM_DEFAULT)
      `uvm_field_int   (cli_pct_ton_override     , UVM_DEFAULT)
      `uvm_field_int   (cli_num_transfers_parsed      , UVM_DEFAULT)
      `uvm_field_int   (cli_min_transfer_size_parsed  , UVM_DEFAULT)
      `uvm_field_int   (cli_max_transfer_size_parsed  , UVM_DEFAULT)
      `uvm_field_int   (cli_min_gap_parsed       , UVM_DEFAULT)
      `uvm_field_int   (cli_max_gap_parsed       , UVM_DEFAULT)
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
      if (cli_num_transfers_override) {
         num_transfers == cli_num_transfers_parsed;
      }
      else {
         /*soft*/ num_transfers == uvmt_axis_st_default_num_transfers;
      }
      
      if (cli_min_transfer_size_override) {
         min_transfer_size == cli_min_transfer_size_parsed;
      }
      else {
         /*soft*/ min_transfer_size == uvmt_axis_st_default_min_transfer_size;
      }
      
      if (cli_max_transfer_size_override) {
         max_transfer_size == cli_max_transfer_size_parsed;
      }
      else {
         /*soft*/ max_transfer_size == uvmt_axis_st_default_max_transfer_size;
      }
      
      if (cli_min_gap_override) {
         min_gap == cli_min_gap_parsed;
      }
      else {
         /*soft*/ min_gap == uvmt_axis_st_default_min_gap;
      }
      
      if (cli_max_gap_override) {
         max_gap == cli_max_gap_parsed;
      }
      else {
         /*soft*/ max_gap == uvmt_axis_st_default_max_gap;
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
   
   string  cli_num_transfers_parsed_str      = "";
   string  cli_min_transfer_size_parsed_str  = "";
   string  cli_max_transfer_size_parsed_str  = "";
   string  cli_min_gap_parsed_str       = "";
   string  cli_max_gap_parsed_str       = "";
   string  cli_pct_ton_parsed_str       = "";
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_num_transfers_str, "="}, cli_num_transfers_parsed_str)) begin
      if (cli_num_transfers_parsed_str != "") begin
         cli_num_transfers_override = 1;
         cli_num_transfers_parsed = cli_num_transfers_parsed_str.atoi();
      end
      else begin
         cli_num_transfers_override = 0;
      end
   end
   else begin
      cli_num_transfers_override = 0;
   end
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_min_transfer_size_str, "="}, cli_min_transfer_size_parsed_str)) begin
      if (cli_min_transfer_size_parsed_str != "") begin
         cli_min_transfer_size_override = 1;
         cli_min_transfer_size_parsed = cli_min_transfer_size_parsed_str.atoi();
      end
      else begin
         cli_min_transfer_size_override = 0;
      end
   end
   else begin
      cli_min_transfer_size_override = 0;
   end
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_max_transfer_size_str, "="}, cli_max_transfer_size_parsed_str)) begin
      if (cli_max_transfer_size_parsed_str != "") begin
         cli_max_transfer_size_override = 1;
         cli_max_transfer_size_parsed = cli_max_transfer_size_parsed_str.atoi();
      end
      else begin
         cli_max_transfer_size_override = 0;
      end
   end
   else begin
      cli_max_transfer_size_override = 0;
   end
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_min_gap_str, "="}, cli_min_gap_parsed_str)) begin
      if (cli_min_gap_parsed_str != "") begin
         cli_min_gap_override = 1;
         cli_min_gap_parsed = cli_min_gap_parsed_str.atoi();
      end
      else begin
         cli_min_gap_override = 0;
      end
   end
   else begin
      cli_min_gap_override = 0;
   end
   
   if (uvm_cmdline_proc.get_arg_value({"+", cli_max_gap_str, "="}, cli_max_gap_parsed_str)) begin
      if (cli_max_gap_parsed_str != "") begin
         cli_max_gap_override = 1;
         cli_max_gap_parsed = cli_max_gap_parsed_str.atoi();
      end
      else begin
         cli_max_gap_override = 0;
      end
   end
   else begin
      cli_max_gap_override = 0;
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
