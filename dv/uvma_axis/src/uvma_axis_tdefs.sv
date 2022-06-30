// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_TDEFS_SV__
`define __UVMA_AXIS_TDEFS_SV__


// Logic vectors
typedef logic                                          uvma_axis_tready_l_t; ///< 
typedef logic                                          uvma_axis_tvalid_l_t; ///< 
typedef logic [(`UVMA_AXIS_TDATA_MAX_WIDTH-1):0][7:0]  uvma_axis_tdata_l_t ; ///< 
typedef logic [(`UVMA_AXIS_TDATA_MAX_WIDTH-1):0]       uvma_axis_tstrb_l_t ; ///< 
typedef logic [(`UVMA_AXIS_TDATA_MAX_WIDTH-1):0]       uvma_axis_tkeep_l_t ; ///< 
typedef logic                                          uvma_axis_tlast_l_t ; ///< 
typedef logic [(`UVMA_AXIS_TID_MAX_WIDTH  -1):0]       uvma_axis_tid_l_t   ; ///< 
typedef logic [(`UVMA_AXIS_TDEST_MAX_WIDTH-1):0]       uvma_axis_tdest_l_t ; ///< 
typedef logic [(`UVMA_AXIS_TUSER_MAX_WIDTH-1):0]       uvma_axis_tuser_l_t ; ///< 

// Bit vectors
typedef bit                                          uvma_axis_tready_b_t; ///< 
typedef bit                                          uvma_axis_tvalid_b_t; ///< 
typedef bit [(`UVMA_AXIS_TDATA_MAX_WIDTH-1):0][7:0]  uvma_axis_tdata_b_t ; ///< 
typedef bit [(`UVMA_AXIS_TDATA_MAX_WIDTH-1):0]       uvma_axis_tstrb_b_t ; ///< 
typedef bit [(`UVMA_AXIS_TDATA_MAX_WIDTH-1):0]       uvma_axis_tkeep_b_t ; ///< 
typedef bit                                          uvma_axis_tlast_b_t ; ///< 
typedef bit [(`UVMA_AXIS_TID_MAX_WIDTH  -1):0]       uvma_axis_tid_b_t   ; ///< 
typedef bit [(`UVMA_AXIS_TDEST_MAX_WIDTH-1):0]       uvma_axis_tdest_b_t ; ///< 
typedef bit [(`UVMA_AXIS_TUSER_MAX_WIDTH-1):0]       uvma_axis_tuser_b_t ; ///< 


/**
 * 
 */
typedef enum {
   UVMA_AXIS_DRV_MODE_MSTR, ///< 
   UVMA_AXIS_DRV_MODE_SLV   ///< 
} uvma_axis_drv_mode_enum;

/**
 * 
 */
typedef enum {
   UVMA_AXIS_RESET_STATE_PRE_RESET , ///< 
   UVMA_AXIS_RESET_STATE_IN_RESET  , ///< 
   UVMA_AXIS_RESET_STATE_POST_RESET  ///< 
} uvma_axis_reset_state_enum;

/**
 * 
 */
typedef enum {
   UVMA_AXIS_DATA_PATTERN_COUNTING, ///< 
   UVMA_AXIS_DATA_PATTERN_RANDOM  , ///< 
   UVMA_AXIS_DATA_PATTERN_ZEROS   , ///< 
   UVMA_AXIS_DATA_PATTERN_AAAA    , ///< 
   UVMA_AXIS_DATA_PATTERN_5555      ///< 
} uvma_axis_data_pattern_enum;

/**
 * 
 */
typedef enum {
   UVMA_AXIS_DRV_IDLE_ZEROS , ///< 
   UVMA_AXIS_DRV_IDLE_RANDOM  ///< 
} uvma_axis_drv_idle_enum;


`endif // __UVMA_AXIS_TDEFS_SV__
