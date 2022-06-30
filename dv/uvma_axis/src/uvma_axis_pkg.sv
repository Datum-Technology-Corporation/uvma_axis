// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_PKG_SV__
`define __UVMA_AXIS_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvma_axis_macros.svh"


timeunit       1ns;
timeprecision  1ps;


// Interfaces / Modules / Checkers
`include "uvma_axis_if.sv"
`ifdef UVMA_AXIS_INC_IF_CHKR
`include "uvma_axis_if_chkr.sv"
`endif


/**
 * Encapsulates all the types needed for the Moore.io UVM agent capable of driving and/or monitoring the AMBA
 * Advanced Extensible Interface Stream (AXIS) protocol.
 */
package uvma_axis_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;

   // Constants / Structs / Enums
   `include "uvma_axis_tdefs.sv"
   `include "uvma_axis_constants.sv"

   // Objects
   `include "uvma_axis_cfg.sv"
   `include "uvma_axis_cntxt.sv"

   // Transactions
   `include "uvma_axis_mon_trn.sv"
   `include "uvma_axis_mstr_mon_trn.sv"
   `include "uvma_axis_slv_mon_trn.sv"
   `include "uvma_axis_seq_item.sv"
   `include "uvma_axis_mstr_seq_item.sv"
   `include "uvma_axis_slv_seq_item.sv"

   // Driver
   `include "uvma_axis_mstr_drv.sv"
   `include "uvma_axis_slv_drv.sv"

   // Virtual Sequencer
   `include "uvma_axis_mstr_sqr.sv"
   `include "uvma_axis_slv_sqr.sv"

   // Agent-Level Components
   `include "uvma_axis_cov_model.sv"
   `include "uvma_axis_logger.sv"
   `include "uvma_axis_drv.sv"
   `include "uvma_axis_mon.sv"
   `include "uvma_axis_vsqr.sv"
   `include "uvma_axis_agent.sv"

   // Sequences
   `include "uvma_axis_base_vseq.sv"
   `include "uvma_axis_mon_vseq.sv"
   `include "uvma_axis_mstr_drv_vseq.sv"
   `include "uvma_axis_slv_drv_vseq.sv"
   `include "uvma_axis_idle_vseq.sv"
   `include "uvma_axis_vseq_lib.sv"

endpackage : uvma_axis_pkg


`endif // __UVMA_AXIS_PKG_SV__
