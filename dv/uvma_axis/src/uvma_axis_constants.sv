// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_CONSTANTS_SV__
`define __UVMA_AXIS_CONSTANTS_SV__


const int unsigned  uvma_axis_default_tdata_width  = `UVMA_AXIS_TDATA_DEFAULT_WIDTH; // Measured in bytes (B)
const int unsigned  uvma_axis_default_tid_width    = `UVMA_AXIS_TID_DEFAULT_WIDTH  ; // Measured in bits  (b)
const int unsigned  uvma_axis_default_tdest_width  = `UVMA_AXIS_TDEST_DEFAULT_WIDTH; // Measured in bits  (b)
const int unsigned  uvma_axis_default_tuser_width  = `UVMA_AXIS_TUSER_DEFAULT_WIDTH; // Measured in bits  (b)

const int unsigned  uvma_axis_max_payload_size  = 32_768; // Measured in bytes (B)
const int unsigned  uvma_axis_min_payload_size  =      8; // Measured in bytes (B)

const int unsigned  uvma_axis_logging_num_data_bytes =  32; // Number of bytes logged at start and end of payload by transaction loggers


`endif // __UVMA_AXIS_CONSTANTS_SV__
