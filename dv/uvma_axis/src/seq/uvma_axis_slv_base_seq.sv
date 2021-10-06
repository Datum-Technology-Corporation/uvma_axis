// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_SLV_BASE_SEQ_SV__
`define __UVMA_AXIS_SLV_BASE_SEQ_SV__


/**
 * TODO Describe uvma_axis_slv_base_seq_c
 */
class uvma_axis_slv_base_seq_c extends uvma_axis_cycle_base_seq_c;
   
   `uvm_object_utils(uvma_axis_slv_base_seq_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_slv_base_seq");
   
endclass : uvma_axis_slv_base_seq_c


function uvma_axis_slv_base_seq_c::new(string name="uvma_axis_slv_base_seq");
   
   super.new(name);
   
endfunction : new


`endif // __UVMA_AXIS_SLV_BASE_SEQ_SV__
