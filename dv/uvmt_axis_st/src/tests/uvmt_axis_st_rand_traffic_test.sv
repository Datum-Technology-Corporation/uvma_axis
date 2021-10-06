// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


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
      /*soft*/ rand_traffic_vseq.num_pkts == test_cfg.num_pkts    ;
      /*soft*/ rand_traffic_vseq.min_size == test_cfg.min_pkt_size;
      /*soft*/ rand_traffic_vseq.max_size == test_cfg.max_pkt_size;
      /*soft*/ rand_traffic_vseq.min_ipg  == test_cfg.min_ipg     ;
      /*soft*/ rand_traffic_vseq.max_ipg  == test_cfg.max_ipg     ;
      /*soft*/ rand_traffic_vseq.pct_ton  == test_cfg.pct_ton     ;
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
   //`uvm_info("TEST", "Hello, World!", UVM_NONE)
   `uvm_info("TEST", $sformatf("Starting rand_traffic_vseq virtual sequence:\n%s", rand_traffic_vseq.sprint()), UVM_NONE)
   rand_traffic_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished rand_traffic_vseq virtual sequence\n%s", rand_traffic_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_AXIS_ST_RAND_TRAFFIC_TEST_SV__
