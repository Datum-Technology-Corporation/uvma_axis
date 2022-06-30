// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_MACROS_SV__
`define __UVMA_AXIS_MACROS_SV__


`ifndef UVMA_AXIS_TDATA_MAX_WIDTH
   `define UVMA_AXIS_TDATA_MAX_WIDTH  1_024
`endif
`ifndef UVMA_AXIS_TID_MAX_WIDTH
   `define UVMA_AXIS_TID_MAX_WIDTH       64
`endif
`ifndef UVMA_AXIS_TDEST_MAX_WIDTH
   `define UVMA_AXIS_TDEST_MAX_WIDTH     64
`endif
`ifndef UVMA_AXIS_TUSER_MAX_WIDTH
   `define UVMA_AXIS_TUSER_MAX_WIDTH     128
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
