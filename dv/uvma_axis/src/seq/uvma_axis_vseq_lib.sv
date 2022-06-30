// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_VSEQ_LIB_SV__
`define __UVMA_AXIS_VSEQ_LIB_SV__


`include "uvma_axis_transport_vseq.sv"
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
   
   add_sequence(uvma_axis_transport_vseq_c   ::get_type());
   add_sequence(uvma_axis_rand_traffic_vseq_c::get_type());
   
endfunction : new


`endif // __UVMA_AXIS_VSEQ_LIB_SV__
