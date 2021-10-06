// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMT_AXIS_ST_TB_SV__
`define __UVMT_AXIS_ST_TB_SV__


/**
 * Module encapsulating the AMBA Advanced Extensible Interface Stream VIP
 * Self-Test DUT wrapper, agents and clock generating interfaces. The clock and
 * reset interface only feeds into the AMBA Advanced Extensible Interface Stream
 * VIP interfaces.
 */
module uvmt_axis_st_tb;
   
   import uvm_pkg::*;
   import uvmt_axis_st_pkg::*;
   //
   // Clocking & Reset
   uvmt_axis_st_clknrst_gen_if  clknrst_gen_if();
   
   // Agent interfaces
   uvma_axis_if  master_if(.clk(clknrst_gen_if.clk), .reset_n(clknrst_gen_if.reset_n));
   uvma_axis_if  slave_if (.clk(clknrst_gen_if.clk), .reset_n(clknrst_gen_if.reset_n));
   
   // DUT instance
   uvmt_axis_st_dut_wrap  dut_wrap(.*);
   
   
   /**
    * Test bench entry point.
    */
   initial begin
      // Specify time format for simulation (units_number, precision_number, suffix_string, minimum_field_width)
      $timeformat(-9, 3, " ns", 18);
      
      // Add interfaces to uvm_config_db
      uvm_config_db#(virtual uvmt_axis_st_clknrst_gen_if)::set(null, "*"                 , "clknrst_gen_vif", clknrst_gen_if);
      uvm_config_db#(virtual uvma_axis_if               )::set(null, "*.env.master_agent", "vif"            , master_if     );
      uvm_config_db#(virtual uvma_axis_if               )::set(null, "*.env.slave_agent" , "vif"            , slave_if      );
      
      // Run test
      uvm_top.enable_print_topology = 1;
      uvm_top.finish_on_completion  = 1;
      uvm_top.run_test();
   end
   
endmodule : uvmt_axis_st_tb


`endif // __UVMT_AXIS_ST_TB_SV__
