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


`ifndef __UVMA_AXIS_MACROS_SV__
`define __UVMA_AXIS_MACROS_SV__


`ifndef UVMA_AXIS_TDATA_MAX_WIDTH
   `define UVMA_AXIS_TDATA_MAX_WIDTH  1_024
`endif
`ifndef UVMA_AXIS_TID_MAX_WIDTH
   `define UVMA_AXIS_TID_MAX_WIDTH        8
`endif
`ifndef UVMA_AXIS_TDEST_MAX_WIDTH
   `define UVMA_AXIS_TDEST_MAX_WIDTH      4
`endif
`ifndef UVMA_AXIS_TUSER_MAX_WIDTH
   `define UVMA_AXIS_TUSER_MAX_WIDTH  1_024
`endif

`ifndef UVMA_AXIS_TDATA_DEFAULT_WIDTH
   `define UVMA_AXIS_TDATA_DEFAULT_WIDTH  32
`endif
`ifndef UVMA_AXIS_TID_DEFAULT_WIDTH
   `define UVMA_AXIS_TID_DEFAULT_WIDTH     8
`endif
`ifndef UVMA_AXIS_TDEST_DEFAULT_WIDTH
   `define UVMA_AXIS_TDEST_DEFAULT_WIDTH   4
`endif
`ifndef UVMA_AXIS_TUSER_DEFAULT_WIDTH
   `define UVMA_AXIS_TUSER_DEFAULT_WIDTH  32
`endif

`ifndef UVMA_AXIS_MSTR_IDLE_SEQ_ITEM_PRI
   `define UVMA_AXIS_MSTR_IDLE_SEQ_ITEM_PRI 1
`endif
`ifndef UVMA_AXIS_SLV_IDLE_SEQ_ITEM_PRI
   `define UVMA_AXIS_SLV_IDLE_SEQ_ITEM_PRI 1
`endif
`ifndef UVMA_AXIS_MSTR_DRV_SEQ_ITEM_PRI
   `define UVMA_AXIS_MSTR_DRV_SEQ_ITEM_PRI 100
`endif
`ifndef UVMA_AXIS_SLV_DRV_SEQ_ITEM_PRI
   `define UVMA_AXIS_SLV_DRV_SEQ_ITEM_PRI 100
`endif


`endif // __UVMA_AXIS_MACROS_SV__
