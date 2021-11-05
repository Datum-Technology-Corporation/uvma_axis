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


`ifndef __UVMA_AXIS_CNTXT_SV__
`define __UVMA_AXIS_CNTXT_SV__


/**
 * Object encapsulating all state variables for all AMBA Advanced Extensible Interface Stream agent
 * (uvma_axis_agent_c) components.
 */
class uvma_axis_cntxt_c extends uvml_cntxt_c;
   
   virtual uvma_axis_if      vif                    ; ///< Handle to agent interface
   uvml_reset_state_enum     reset_state            ; ///< 
   uvma_axis_mstr_mon_trn_c  mon_current_transfer[$]; ///< Current data transfer
   
   uvm_sequence_base  mon_vseq     ; ///< 
   uvm_sequence_base  idle_vseq    ; ///< 
   uvm_sequence_base  mstr_drv_vseq; ///< 
   uvm_sequence_base  slv_drv_vseq ; ///< 
   
   // Events
   uvm_event  sample_cfg_e  ; ///< 
   uvm_event  sample_cntxt_e; ///< 
   
   
   `uvm_object_utils_begin(uvma_axis_cntxt_c)
      `uvm_field_enum(uvml_reset_state_enum, reset_state, UVM_DEFAULT)
      
      //`uvm_field_queue_object(mon_current_transfer , UVM_DEFAULT)
      
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Builds events.
    */
   extern function new(string name="uvma_axis_cntxt");
   
   /**
    * TODO Describe uvma_axis_cntxt_c::reset()
    */
   extern function void reset();
   
endclass : uvma_axis_cntxt_c


function uvma_axis_cntxt_c::new(string name="uvma_axis_cntxt");
   
   super.new(name);
   
   reset_state    = UVML_RESET_STATE_PRE_RESET;
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   
endfunction : new


function void uvma_axis_cntxt_c::reset();
   
   mon_current_transfer.delete();
   
endfunction : reset


`endif // __UVMA_AXIS_CNTXT_SV__
