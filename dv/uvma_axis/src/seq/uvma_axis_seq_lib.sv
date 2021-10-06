// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_SEQ_LIB_SV__
`define __UVMA_AXIS_SEQ_LIB_SV__


// Cycle-based: convert payloads to cycles
`include "uvma_axis_cycle_base_seq.sv"
`include "uvma_axis_cycle_throttled_seq.sv"

// Master/Slave
`include "uvma_axis_base_seq.sv"
`include "uvma_axis_mstr_base_seq.sv"
`include "uvma_axis_mstr_object_seq.sv"
`include "uvma_axis_mstr_rand_traffic_seq.sv"
`include "uvma_axis_slv_base_seq.sv"
`include "uvma_axis_slv_rand_rdy_seq.sv"


/**
 * Object holding sequence library for AMBA Advanced Extensible Interface Stream agent.
 */
class uvma_axis_seq_lib_c extends uvm_sequence_library#(
   .REQ(uvma_axis_seq_item_c),
   .RSP(uvma_axis_seq_item_c)
);
   
   `uvm_object_utils          (uvma_axis_seq_lib_c)
   `uvm_sequence_library_utils(uvma_axis_seq_lib_c)
   
   
   /**
    * Initializes sequence library
    */
   extern function new(string name="uvma_axis_seq_lib");
   
endclass : uvma_axis_seq_lib_c


function uvma_axis_seq_lib_c::new(string name="uvma_axis_seq_lib");
   
   super.new(name);
   init_sequence_library();
   
   // TODO Add sequences to uvma_axis_seq_lib_c
   //      Ex: add_sequence(uvma_axis_abc_seq_c::get_type());
   
endfunction : new


`endif // __UVMA_AXIS_SEQ_LIB_SV__
