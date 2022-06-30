// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
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
