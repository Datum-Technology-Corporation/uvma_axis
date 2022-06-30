// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_AXIS_ST_DUT_WRAP_SV__
`define __UVMT_AXIS_ST_DUT_WRAP_SV__


/**
 * Module wrapper for AMBA Advanced Extensible Interface Stream RTL DUT. All ports are SV interfaces.
 */
module uvmt_axis_st_dut_wrap(
   uvma_axis_if  mstr_if,
   uvma_axis_if  slv_if
);
   
   assign mstr_if.tready = slv_if .tready;
   assign slv_if .tvalid = mstr_if.tvalid;
   assign slv_if .tdata  = mstr_if.tdata ;
   assign slv_if .tstrb  = mstr_if.tstrb ;
   assign slv_if .tkeep  = mstr_if.tkeep ;
   assign slv_if .tlast  = mstr_if.tlast ;
   assign slv_if .tid    = mstr_if.tid   ;
   assign slv_if .tdest  = mstr_if.tdest ;
   assign slv_if .tuser  = mstr_if.tuser ;
   
endmodule : uvmt_axis_st_dut_wrap


`endif // __UVMT_AXIS_ST_DUT_WRAP_SV__
