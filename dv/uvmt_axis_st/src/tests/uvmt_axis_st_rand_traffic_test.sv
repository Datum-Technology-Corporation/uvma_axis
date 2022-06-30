// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_AXIS_ST_RAND_TRAFFIC_TEST_SV__
`define __UVMT_AXIS_ST_RAND_TRAFFIC_TEST_SV__


/**
 * TODO Describe uvmt_axis_st_rand_traffic_test_c
 */
class uvmt_axis_st_rand_traffic_test_c extends uvmt_axis_st_base_test_c;
   
   rand uvme_axis_st_rand_traffic_vseq_c  rand_traffic_vseq;
   
   
   `uvm_component_utils_begin(uvmt_axis_st_rand_traffic_test_c)
      `uvm_field_object(rand_traffic_vseq, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   constraint test_cfg_cons {
      /*soft*/ rand_traffic_vseq.num_transfers == test_cfg.num_transfers    ;
      /*soft*/ rand_traffic_vseq.min_size      == test_cfg.min_transfer_size;
      /*soft*/ rand_traffic_vseq.max_size      == test_cfg.max_transfer_size;
      /*soft*/ rand_traffic_vseq.min_gap       == test_cfg.min_gap          ;
      /*soft*/ rand_traffic_vseq.max_gap       == test_cfg.max_gap          ;
   }
   
   
   /**
    * Creates rand_traffic_vseq.
    */
   extern function new(string name="uvmt_axis_st_rand_traffic_test", uvm_component parent=null);
   
   /**
    * Runs rand_traffic_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);
   
endclass : uvmt_axis_st_rand_traffic_test_c


function uvmt_axis_st_rand_traffic_test_c::new(string name="uvmt_axis_st_rand_traffic_test", uvm_component parent=null);
   
   super.new(name, parent);
   
   rand_traffic_vseq = uvme_axis_st_rand_traffic_vseq_c::type_id::create("rand_traffic_vseq");
   
endfunction : new


task uvmt_axis_st_rand_traffic_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting rand_traffic_vseq virtual sequence:\n%s", rand_traffic_vseq.sprint()), UVM_NONE)
   rand_traffic_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished rand_traffic_vseq virtual sequence\n%s", rand_traffic_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_AXIS_ST_RAND_TRAFFIC_TEST_SV__
