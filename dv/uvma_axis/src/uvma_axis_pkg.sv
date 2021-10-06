// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_PKG_SV__
`define __UVMA_AXIS_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_hrtbt_macros.sv"
`include "uvma_axis_macros.sv"


timeunit       1ns;
timeprecision  1ps;


// Interfaces / Modules / Checkers
`include "uvma_axis_if.sv"
`ifdef UVMA_AXIS_INC_IF_CHKR
`include "uvma_axis_if_chkr.sv"
`endif


/**
 * Encapsulates all the types needed for the Moore.io UVM agent capable of
 * driving and/or monitoring the AMBA Advanced Extensible Interface Stream
 * (AXIS) protocol.
 */
package uvma_axis_pkg;
   
   import uvm_pkg       ::*;
   import uvml_hrtbt_pkg::*;
   import uvml_trn_pkg  ::*;
   import uvml_logs_pkg ::*;
   
   // Constants / Structs / Enums
   `include "uvma_axis_constants.sv"
   `include "uvma_axis_tdefs.sv"
   
   // Objects
   `include "uvma_axis_cfg.sv"
   `include "uvma_axis_cntxt.sv"
   
   // High-level transactions
   `include "uvma_axis_mon_trn.sv"
   `include "uvma_axis_mon_trn_logger.sv"
   `include "uvma_axis_seq_item.sv"
   `include "uvma_axis_seq_item_logger.sv"
   
   // Cycle transactions
   `include "uvma_axis_cycle_mon_trn.sv"
   `include "uvma_axis_cycle_mon_trn_logger.sv"
   `include "uvma_axis_cycle_seq_item.sv"
   `include "uvma_axis_cycle_seq_item_logger.sv"
   
   // Agent components
   `include "uvma_axis_cov_model.sv"
   `include "uvma_axis_drv.sv"
   `include "uvma_axis_mon.sv"
   `include "uvma_axis_cycle_sqr.sv"
   `include "uvma_axis_sqr.sv"
   `include "uvma_axis_agent.sv"
   
   // Sequences
   `include "uvma_axis_seq_lib.sv"
   
endpackage : uvma_axis_pkg


`endif // __UVMA_AXIS_PKG_SV__
