// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_AXIS_ST_MACROS_SV__
`define __UVMT_AXIS_ST_MACROS_SV__


`ifndef UVMT_AXIS_ST_CLI_ARG_NUM_TRANSFERS
   `define UVMT_AXIS_ST_CLI_ARG_NUM_TRANSFERS "NTRN"
`endif
`ifndef UVMT_AXIS_ST_CLI_ARG_MIN_TRANSFER_SIZE
   `define UVMT_AXIS_ST_CLI_ARG_MIN_TRANSFER_SIZE "MINSZ"
`endif
`ifndef UVMT_AXIS_ST_CLI_ARG_MAX_TRANSFER_SIZE
   `define UVMT_AXIS_ST_CLI_ARG_MAX_TRANSFER_SIZE "MAXSZ"
`endif
`ifndef UVMT_AXIS_ST_CLI_ARG_MIN_GAP
   `define UVMT_AXIS_ST_CLI_ARG_MIN_GAP "MINGAP"
`endif
`ifndef UVMT_AXIS_ST_CLI_ARG_MAX_GAP
   `define UVMT_AXIS_ST_CLI_ARG_MAX_GAP "MAXGAP"
`endif
`ifndef UVMT_AXIS_ST_CLI_ARG_MSTR_TON
   `define UVMT_AXIS_ST_CLI_ARG_MSTR_TON "MSTRON"
`endif
`ifndef UVMT_AXIS_ST_CLI_ARG_SLV_TON
   `define UVMT_AXIS_ST_CLI_ARG_SLV_TON "SLVON"
`endif


`endif // __UVMT_AXIS_ST_MACROS_SV__
