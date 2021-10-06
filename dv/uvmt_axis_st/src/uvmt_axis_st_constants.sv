// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMT_AXIS_ST_CONSTANTS_SV__
`define __UVMT_AXIS_ST_CONSTANTS_SV__


const int unsigned uvmt_axis_st_default_clk_period          =     10_000; //  10 ns (100 Mhz)
const int unsigned uvmt_axis_st_default_reset_period        =         10; //  10 ns
const int unsigned uvmt_axis_st_default_startup_timeout     =    200_000; //  2 us // TODO Set default Heartbeat Monitor startup timeout
const int unsigned uvmt_axis_st_default_heartbeat_period    =    200_000; //  2 us // TODO Set default Heartbeat Monitor period
const int unsigned uvmt_axis_st_default_simulation_timeout  = 10_000_000; // 10 ms // TODO Set default simulation timeout

const int unsigned uvmt_axis_st_default_num_pkts      =   100;
const int unsigned uvmt_axis_st_default_min_pkt_size  =    64;
const int unsigned uvmt_axis_st_default_max_pkt_size  = 1_024;
const int unsigned uvmt_axis_st_default_min_ipg       =     0;
const int unsigned uvmt_axis_st_default_max_ipg       =     8;
const int unsigned uvmt_axis_st_default_pct_ton       =    85;


`endif // __UVMT_AXIS_ST_CONSTANTS_SV__
