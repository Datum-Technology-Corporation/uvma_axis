// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_AXIS_ST_CNTXT_SV__
`define __UVME_AXIS_ST_CNTXT_SV__


/**
 * Object encapsulating all state variables for AMBA Advanced Extensible Interface Stream VIP Self-Testing environment
 * (uvme_axis_st_env_c) components.
 */
class uvme_axis_st_cntxt_c extends uvml_cntxt_c;
   
   // Agent context handles
   uvma_axis_cntxt_c  mstr_cntxt; ///< 
   uvma_axis_cntxt_c  slv_cntxt ; ///< 
   
   // Scoreboard context handle
   uvml_sb_simplex_cntxt_c  sb_mstr_cntxt; ///< 
   uvml_sb_simplex_cntxt_c  sb_e2e_cntxt ; ///< 
   
   // Events
   uvm_event  sample_cfg_e  ; ///< 
   uvm_event  sample_cntxt_e; ///< 
   
   
   `uvm_object_utils_begin(uvme_axis_st_cntxt_c)
      `uvm_field_object(mstr_cntxt, UVM_DEFAULT)
      `uvm_field_object(slv_cntxt , UVM_DEFAULT)
      
      `uvm_field_object(sb_mstr_cntxt, UVM_DEFAULT)
      `uvm_field_object(sb_e2e_cntxt , UVM_DEFAULT)
      
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
   
   mstr_cntxt    = uvma_axis_cntxt_c      ::type_id::create("mstr_cntxt"   );
   slv_cntxt     = uvma_axis_cntxt_c      ::type_id::create("slv_cntxt"    );
   sb_mstr_cntxt = uvml_sb_simplex_cntxt_c::type_id::create("sb_mstr_cntxt");
   sb_e2e_cntxt  = uvml_sb_simplex_cntxt_c::type_id::create("sb_e2e_cntxt" );
   
   sample_cfg_e   = new("sample_cfg_e"  );
   sample_cntxt_e = new("sample_cntxt_e");
   
endfunction : new


`endif // __UVME_AXIS_ST_CNTXT_SV__
