// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_AXIS_ST_PKG_SV__
`define __UVMT_AXIS_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvml_sb_macros.svh"
`include "uvma_axis_macros.svh"
`include "uvme_axis_st_macros.svh"
`include "uvmt_axis_st_macros.svh"

// Time units and precision for this test bench
timeunit       1ns;
timeprecision  1ps;

// Interface(s)
`include "uvmt_axis_st_clknrst_gen_if.sv"


/**
 * Encapsulates all the types and test cases for self-testing the Moore.io AMBA Advanced Extensible Interface Stream
 * (AXIS) UVM Agent.
 */
package uvmt_axis_st_pkg;

   import uvm_pkg         ::*;
   import uvml_pkg        ::*;
   import uvml_logs_pkg   ::*;
   import uvml_sb_pkg     ::*;
   import uvma_axis_pkg   ::*;
   import uvme_axis_st_pkg::*;

   // Constants / Structs / Enums
   `include "uvmt_axis_st_tdefs.sv"
   `include "uvmt_axis_st_constants.sv"

   // Virtual sequence library
   `include "uvmt_axis_st_vseq_lib.sv"

   // Base test
   `include "uvmt_axis_st_test_cfg.sv"
   `include "uvmt_axis_st_base_test.sv"

   // Functional tests
   `include "uvmt_axis_st_rand_traffic_test.sv"

endpackage : uvmt_axis_st_pkg


// Module(s) / Checker(s)
`include "uvmt_axis_st_dut_wrap.sv"
`ifdef UVMT_AXIS_ST_INC_CHKR
`include "uvmt_axis_st_dut_chkr.sv"
`endif
`include "uvmt_axis_st_tb.sv"


`endif // __UVMT_AXIS_ST_PKG_SV__
