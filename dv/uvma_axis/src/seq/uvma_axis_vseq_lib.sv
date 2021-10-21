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


`ifndef __UVMA_AXIS_VSEQ_LIB_SV__
`define __UVMA_AXIS_VSEQ_LIB_SV__


`include "uvma_axis_base_vseq.sv"
`include "uvma_axis_idle_vseq.sv"
`include "uvma_axis_payload_vseq.sv"
`include "uvma_axis_rand_traffic_vseq.sv"


/**
 * Object holding sequence library for AMBA Advanced Extensible Interface Stream agent.
 */
class uvma_axis_vseq_lib_c extends uvml_vseq_lib_c #(
   .REQ(uvma_axis_seq_item_c),
   .RSP(uvma_axis_seq_item_c)
);
   
   `uvm_object_utils          (uvma_axis_vseq_lib_c)
   `uvm_sequence_library_utils(uvma_axis_vseq_lib_c)
   
   
   /**
    * Initializes sequence library
    */
   extern function new(string name="uvma_axis_vseq_lib");
   
endclass : uvma_axis_vseq_lib_c


function uvma_axis_vseq_lib_c::new(string name="uvma_axis_vseq_lib");
   
   super.new(name);
   init_sequence_library();
   
   add_sequence(uvma_axis_idle_vseq_c        ::get_type());
   add_sequence(uvma_axis_payload_vseq_c     ::get_type());
   add_sequence(uvma_axis_rand_traffic_vseq_c::get_type());
   
endfunction : new


`endif // __UVMA_AXIS_VSEQ_LIB_SV__
