// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_AXIS_ST_CFG_SV__
`define __UVME_AXIS_ST_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running
 * AMBA Advanced Extensible Interface Stream VIP Self-Testing Environment (uvme_axis_st_env_c)
 * components.
 */
class uvme_axis_st_cfg_c extends uvml_cfg_c;
   
   // Integrals
   rand bit                      enabled              ; ///< 
   rand uvm_active_passive_enum  is_active            ; ///< 
   rand bit                      scoreboarding_enabled; ///< 
   rand bit                      cov_model_enabled    ; ///< 
   rand bit                      trn_log_enabled      ; ///< 
   
   // Objects
   rand uvma_axis_cfg_c        mstr_cfg   ; ///< 
   rand uvma_axis_cfg_c        slv_cfg    ; ///< 
   rand uvml_sb_simplex_cfg_c  sb_mstr_cfg; ///< 
   rand uvml_sb_simplex_cfg_c  sb_e2e_cfg ; ///< 
   
   
   `uvm_object_utils_begin(uvme_axis_st_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active            , UVM_DEFAULT)
      `uvm_field_int (                         scoreboarding_enabled, UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)
      
      `uvm_field_object(mstr_cfg   , UVM_DEFAULT)
      `uvm_field_object(slv_cfg    , UVM_DEFAULT)
      `uvm_field_object(sb_mstr_cfg, UVM_DEFAULT)
      `uvm_field_object(sb_e2e_cfg , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint agent_cfg_cons {
      if (enabled) {
         mstr_cfg.enabled == 1;
         slv_cfg .enabled == 1;
      }
      else {
         mstr_cfg.enabled == 0;
         slv_cfg .enabled == 0;
      }
      
      if (is_active == UVM_ACTIVE) {
         mstr_cfg.is_active == UVM_ACTIVE;
         slv_cfg .is_active == UVM_ACTIVE;
      }
      else {
         mstr_cfg.is_active == UVM_PASSIVE;
         slv_cfg .is_active == UVM_PASSIVE;
      }
      
      if (trn_log_enabled) {
         mstr_cfg.trn_log_enabled == 1;
         slv_cfg .trn_log_enabled == 1;
      }
      else {
         mstr_cfg.trn_log_enabled == 0;
         slv_cfg .trn_log_enabled == 0;
      }
      
      mstr_cfg.drv_mode == UVMA_AXIS_DRV_MODE_MSTR;
      slv_cfg .drv_mode == UVMA_AXIS_DRV_MODE_SLV ;
      
      mstr_cfg.bypass_mode == 0;
      slv_cfg .bypass_mode == 0;
      mstr_cfg.reset_type  == slv_cfg.reset_type;
      mstr_cfg.tdata_width == slv_cfg.tdata_width;
      mstr_cfg.tid_width   == slv_cfg.tid_width  ;
      mstr_cfg.tdest_width == slv_cfg.tdest_width;
      mstr_cfg.tuser_width == slv_cfg.tuser_width;
   }
   
   constraint sb_cfg_cons {
      sb_mstr_cfg.mode == UVML_SB_MODE_IN_ORDER;
      sb_e2e_cfg .mode == UVML_SB_MODE_IN_ORDER;
      if (scoreboarding_enabled) {
         sb_mstr_cfg.enabled == 1;
         sb_e2e_cfg .enabled == 1;
      }
      else {
         sb_mstr_cfg.enabled == 0;
         sb_e2e_cfg .enabled == 0;
      }
   }
   
   
   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvme_axis_st_cfg");
   
endclass : uvme_axis_st_cfg_c


function uvme_axis_st_cfg_c::new(string name="uvme_axis_st_cfg");
   
   super.new(name);
   
   mstr_cfg    = uvma_axis_cfg_c      ::type_id::create("mstr_cfg"   );
   slv_cfg     = uvma_axis_cfg_c      ::type_id::create("slv_cfg"    );
   sb_mstr_cfg = uvml_sb_simplex_cfg_c::type_id::create("sb_mstr_cfg");
   sb_e2e_cfg  = uvml_sb_simplex_cfg_c::type_id::create("sb_e2e_cfg" );
   
endfunction : new


`endif // __UVME_AXIS_ST_CFG_SV__
