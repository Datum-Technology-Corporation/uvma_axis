// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_AXIS_ST_SB_ENTRY_SV__
`define __UVME_AXIS_ST_SB_ENTRY_SV__


/**
 * TODO Describe uvme_axis_st_sb_entry_c
 */
class uvme_axis_st_sb_entry_c extends uvml_sb_entry_c;
   
   // Fields
   
   
   
   `uvm_object_utils_begin(uvme_axis_st_sb_entry_c)
      // UVM Field Util Macros
   `uvm_object_utils_end
   
   
   // Constraints
   
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_axis_st_sb_entry");
   
   // Methods
   
   
endclass : uvme_axis_st_sb_entry_c


`pragma protect begin


function uvme_axis_st_sb_entry_c::new(string name="uvme_axis_st_sb_entry");
   
   super.new(name);
   
endfunction : new


`pragma protect end


`endif // __UVME_AXIS_ST_SB_ENTRY_SV__
