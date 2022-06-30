// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_AXIS_ST_PKG_SV__
`define __UVME_AXIS_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvml_sb_macros.svh"
`include "uvma_axis_macros.svh"
`include "uvme_axis_st_macros.svh"


// Interface(s)


 /**
 * Encapsulates all the types needed for the Moore.io UVM environment capable of self-testing the Moore.io AMBA
 * Advanced Extensible Interface Stream (AXIS) UVM Agent.
 */
package uvme_axis_st_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;
   import uvml_sb_pkg  ::*;
   import uvma_axis_pkg::*;

   // Constants / Structs / Enums
   `include "uvme_axis_st_tdefs.sv"
   `include "uvme_axis_st_constants.sv"

   // Objects
   `include "uvme_axis_st_cfg.sv"
   `include "uvme_axis_st_cntxt.sv"

   // Environment components
   `include "uvme_axis_st_cov_model.sv"
   `include "uvme_axis_st_prd.sv"
   `include "uvme_axis_st_vsqr.sv"
   `include "uvme_axis_st_env.sv"

   // Virtual sequences
   `include "uvme_axis_st_vseq_lib.sv"

endpackage : uvme_axis_st_pkg


// Module(s) / Checker(s)
`ifdef UVME_AXIS_ST_INC_CHKR
`include "uvme_axis_st_chkr.sv"
`endif


`endif // __UVME_AXIS_ST_PKG_SV__
