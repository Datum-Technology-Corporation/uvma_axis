// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMT_AXIS_ST_DUT_WRAP_SV__
`define __UVMT_AXIS_ST_DUT_WRAP_SV__


/**
 * Module wrapper for AMBA Advanced Extensible Interface Stream RTL DUT. All ports are SV interfaces.
 */
module uvmt_axis_st_dut_wrap(
   uvma_axis_if  master_if,
   uvma_axis_if  slave_if
);

   // Connect the 2 interfaces
   assign master_if.tready = slave_if .tready;
   assign slave_if .tvalid = master_if.tvalid;
   assign slave_if .tdata  = master_if.tdata ;
   assign slave_if .tstrb  = master_if.tstrb ;
   assign slave_if .tkeep  = master_if.tkeep ;
   assign slave_if .tlast  = master_if.tlast ;
   assign slave_if .tid    = master_if.tid   ;
   assign slave_if .tdest  = master_if.tdest ;
   assign slave_if .tuser  = master_if.tuser ;
   
endmodule : uvmt_axis_st_dut_wrap


`endif // __UVMT_AXIS_ST_DUT_WRAP_SV__
