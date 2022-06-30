// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_AXIS_ST_RAND_TRAFFIC_VSEQ_SV__
`define __UVME_AXIS_ST_RAND_TRAFFIC_VSEQ_SV__


/**
 * TODO Describe uvme_axis_st_rand_traffic_vseq_c
 */
class uvme_axis_st_rand_traffic_vseq_c extends uvme_axis_st_base_vseq_c;
   
   // Knobs
   rand int unsigned  num_transfers;
   rand int unsigned  min_size     ;
   rand int unsigned  max_size     ;
   rand int unsigned  min_gap      ;
   rand int unsigned  max_gap      ;
   
   // Sequences
   rand uvma_axis_rand_traffic_vseq_c  mstr_vseq;
   
   
   `uvm_object_utils_begin(uvme_axis_st_rand_traffic_vseq_c)
      `uvm_field_int(num_transfers, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_size     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_size     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_gap      , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_gap      , UVM_DEFAULT + UVM_DEC)
      
      `uvm_field_object(mstr_vseq, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint limits_cons {
      num_transfers inside {[1:100]};
      min_gap  <= max_gap ;
      min_size <= max_size;
      min_size >  0;
      max_size <= 512;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_axis_st_rand_traffic_vseq");
   
   /**
    * TODO Describe uvme_axis_st_rand_traffic_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvme_axis_st_rand_traffic_vseq_c


function uvme_axis_st_rand_traffic_vseq_c::new(string name="uvme_axis_st_rand_traffic_vseq");
   
   super.new(name);
   
endfunction : new


task uvme_axis_st_rand_traffic_vseq_c::body();
   
   `uvm_do_on_with(mstr_vseq, p_sequencer.mstr_vsequencer, {
      num_transfers == local::num_transfers;
      min_size      == local::min_size;
      max_size      == local::max_size;
      min_gap       == local::min_gap ;
      max_gap       == local::max_gap ;
   })
   
endtask : body


`endif // __UVME_AXIS_ST_RAND_TRAFFIC_VSEQ_SV__
