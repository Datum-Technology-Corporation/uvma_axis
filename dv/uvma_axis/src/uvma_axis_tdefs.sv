// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_TDEFS_SV__
`define __UVMA_AXIS_TDEFS_SV__


typedef enum {
   UVMA_AXIS_MODE_MASTER,
   UVMA_AXIS_MODE_SLAVE
} uvma_axis_mode_enum;

typedef enum {
   UVMA_AXIS_RESET_STATE_PRE_RESET ,
   UVMA_AXIS_RESET_STATE_IN_RESET  ,
   UVMA_AXIS_RESET_STATE_POST_RESET
} uvma_axis_reset_state_enum;

typedef enum {
   UVMA_AXIS_DATA_PATTERN_COUNTING,
   UVMA_AXIS_DATA_PATTERN_RANDOM  ,
   UVMA_AXIS_DATA_PATTERN_ZEROS   ,
   UVMA_AXIS_DATA_PATTERN_AAAA    ,
   UVMA_AXIS_DATA_PATTERN_5555
} uvma_axis_data_pattern_enum;

typedef enum {
   UVMA_AXIS_DRV_IDLE_SAME  ,
   UVMA_AXIS_DRV_IDLE_ZEROS ,
   UVMA_AXIS_DRV_IDLE_RANDOM,
   UVMA_AXIS_DRV_IDLE_X     ,
   UVMA_AXIS_DRV_IDLE_Z
} uvma_axis_drv_idle_enum;


`endif // __UVMA_AXIS_TDEFS_SV__
