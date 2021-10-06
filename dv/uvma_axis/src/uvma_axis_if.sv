// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_IF_SV__
`define __UVMA_AXIS_IF_SV__


/**
 * Encapsulates all signals and clocking of AMBA Advanced Extensible Interface Stream interface. Used by
 * monitor (uvma_axis_mon_c) and driver (uvma_axis_drv_c).
 */
interface uvma_axis_if (
   input logic clk    ,
   input logic reset_n
);
   
   // Slave-out signals
   wire                                         tready;
   
   // Master-out signals
   wire                                         tvalid;
   wire [(`UVMA_AXIS_TDATA_MAX_SIZE-1):0][7:0]  tdata ;
   wire [(`UVMA_AXIS_TDATA_MAX_SIZE-1):0]       tstrb ;
   wire [(`UVMA_AXIS_TDATA_MAX_SIZE-1):0]       tkeep ;
   wire                                         tlast ;
   wire [(  `UVMA_AXIS_TID_MAX_SIZE-1):0]       tid   ;
   wire [(`UVMA_AXIS_TDEST_MAX_SIZE-1):0]       tdest ;
   wire [(`UVMA_AXIS_TUSER_MAX_SIZE-1):0]       tuser ;
   
   
   /**
    * Used by DUT in 'master' mode.
    */
   clocking dut_master_cb @(posedge clk);
      input   tready;
      output  tvalid,
              tdata ,
              tstrb ,
              tkeep ,
              tlast ,
              tid   ,
              tdest ,
              tuser ;
   endclocking : dut_master_cb
   
   /**
    * Used by DUT in 'master' mode.
    */
   clocking dut_slave_cb @(posedge clk);
      output  tready;
      input   tvalid,
              tdata ,
              tstrb ,
              tkeep ,
              tlast ,
              tid   ,
              tdest ,
              tuser ;
   endclocking : dut_slave_cb
   
   /**
    * Used by uvma_axis_drv_c.
    */
   clocking drv_master_cb @(posedge clk);
      input   tready;
      output  tvalid,
              tdata ,
              tstrb ,
              tkeep ,
              tlast ,
              tid   ,
              tdest ,
              tuser ;
   endclocking : drv_master_cb
   
   /**
    * Used by uvma_axis_drv_c.
    */
   clocking drv_slave_cb @(posedge clk);
      output  tready;
      input   tvalid,
              tdata ,
              tstrb ,
              tkeep ,
              tlast ,
              tid   ,
              tdest ,
              tuser ;
   endclocking : drv_slave_cb
   
   /**
    * Used by uvma_axis_mon_c.
    */
   clocking mon_cb @(posedge clk);
      input  tready,
             tvalid,
             tdata ,
             tstrb ,
             tkeep ,
             tlast ,
             tid   ,
             tdest ,
             tuser ;
   endclocking : mon_cb
   
   
   modport dut_master_mp   (clocking dut_master_cb);
   modport dut_slave_mp    (clocking dut_slave_cb );
   modport active_master_mp(clocking drv_master_cb);
   modport active_slave_mp (clocking drv_slave_cb );
   modport passive_mp      (clocking mon_cb       );
   
endinterface : uvma_axis_if


`endif // __UVMA_AXIS_IF_SV__
