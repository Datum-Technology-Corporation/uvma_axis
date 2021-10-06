// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_AXIS_ST_CNTXT_SV__
`define __UVME_AXIS_ST_CNTXT_SV__


/**
 * Object encapsulating all state variables for AMBA Advanced Extensible
 * Interface Stream VIP Self-Testing environment (uvme_axis_st_env_c)
 * components.
 */
class uvme_axis_st_cntxt_c extends uvm_object;
   
   // Agent context handles
   uvma_axis_cntxt_c  master_cntxt;
   uvma_axis_cntxt_c  slave_cntxt;
   
   // Scoreboard context handle
   uvml_sb_cntxt_c  sb_cntxt;
   
   // Events
   uvm_event  sample_cfg_e  ;
   uvm_event  sample_cntxt_e;
   
   
   `uvm_object_utils_begin(uvme_axis_st_cntxt_c)
      `uvm_field_object(master_cntxt, UVM_DEFAULT)
      `uvm_field_object(slave_cntxt, UVM_DEFAULT)
      
      //`uvm_field_object(sb_cntxt, UVM_DEFAULT)
      
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Builds events and sub-context objects.
    */
   extern function new(string name="uvme_axis_st_cntxt");
   
endclass : uvme_axis_st_cntxt_c


function uvme_axis_st_cntxt_c::new(string name="uvme_axis_st_cntxt");
   
   super.new(name);
   
   master_cntxt = uvma_axis_cntxt_c::type_id::create("master_cntxt");
   slave_cntxt  = uvma_axis_cntxt_c::type_id::create("slave_cntxt" );
   sb_cntxt     = uvml_sb_cntxt_c  ::type_id::create("sb_cntxt"    );
   
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   
endfunction : new


`endif // __UVME_AXIS_ST_CNTXT_SV__
