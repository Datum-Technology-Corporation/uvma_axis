// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_IF_SV__
`define __UVMA_AXIS_IF_SV__


/**
 * Encapsulates all signals and clocking of AMBA Advanced Extensible Interface Stream interface. Used by
 * monitor (uvma_axis_mon_c) and driver (uvma_axis_drv_c).
 */
interface uvma_axis_if #(
   parameter TDATA_WIDTH  = `UVMA_AXIS_TDATA_MAX_WIDTH, ///< 
   parameter TUSER_WIDTH  = `UVMA_AXIS_TUSER_MAX_WIDTH, ///< 
   parameter TDEST_WIDTH  = `UVMA_AXIS_TDEST_MAX_WIDTH, ///< 
   parameter TID_WIDTH    = `UVMA_AXIS_TID_MAX_WIDTH    ///< 
) (
   input logic clk    ,
   input logic reset_n
);
   
   // Slave-out signals
   wire                           tready; ///< 
   
   // Master-out signals
   wire                           tvalid; ///< 
   wire [(TDATA_WIDTH-1):0][7:0]  tdata ; ///< 
   wire [(TDATA_WIDTH-1):0]       tstrb ; ///< 
   wire [(TDATA_WIDTH-1):0]       tkeep ; ///< 
   wire                           tlast ; ///< 
   wire [(TID_WIDTH  -1):0]       tid   ; ///< 
   wire [(TDEST_WIDTH-1):0]       tdest ; ///< 
   wire [(TUSER_WIDTH-1):0]       tuser ; ///< 
   
   
   /**
    * Used by DUT in 'mstr' mode.
    */
   clocking dut_mstr_cb @(posedge clk);
      input   tready;
      output  tvalid,
              tdata ,
              tstrb ,
              tkeep ,
              tlast ,
              tid   ,
              tdest ,
              tuser ;
   endclocking : dut_mstr_cb
   
   /**
    * Used by DUT in 'mstr' mode.
    */
   clocking dut_slv_cb @(posedge clk);
      output  tready;
      input   tvalid,
              tdata ,
              tstrb ,
              tkeep ,
              tlast ,
              tid   ,
              tdest ,
              tuser ;
   endclocking : dut_slv_cb
   
   /**
    * Used by uvma_axis_drv_c.
    */
   clocking drv_mstr_cb @(posedge clk);
      input   tready;
      output  tvalid,
              tdata ,
              tstrb ,
              tkeep ,
              tlast ,
              tid   ,
              tdest ,
              tuser ;
   endclocking : drv_mstr_cb
   
   /**
    * Used by uvma_axis_drv_c.
    */
   clocking drv_slv_cb @(posedge clk);
      output  tready;
      input   tvalid,
              tdata ,
              tstrb ,
              tkeep ,
              tlast ,
              tid   ,
              tdest ,
              tuser ;
   endclocking : drv_slv_cb
   
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
   
   
   /**
    * 
    */
   modport dut_mstr_mp   (
      clocking  dut_mstr_cb,
      input     clk        ,
      input     reset_n
   );
   
   /**
    * 
    */
   modport dut_slv_mp    (
      clocking  dut_slv_cb,
      input     clk       ,
      input     reset_n
   );
   
   /**
    * 
    */
   modport drv_mstr_mp(
      clocking  drv_mstr_cb,
      input     clk        ,
      input     reset_n
   );
   
      
   /**
    * 
    */
   modport drv_slv_mp (
      clocking  drv_slv_cb,
      input     clk       ,
      input     reset_n
   );
   
   /**
    * 
    */
   modport mon_mp (
      clocking  mon_cb ,
      input     clk    ,
      input     reset_n
   );
   
endinterface : uvma_axis_if


`endif // __UVMA_AXIS_IF_SV__
