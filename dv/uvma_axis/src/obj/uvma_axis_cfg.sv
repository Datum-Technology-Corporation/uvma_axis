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


`ifndef __UVMA_AXIS_CFG_SV__
`define __UVMA_AXIS_CFG_SV__


// Default sequences
typedef class uvma_axis_mon_vseq_c     ;
typedef class uvma_axis_idle_vseq_c    ;
typedef class uvma_axis_mstr_drv_vseq_c;
typedef class uvma_axis_slv_drv_vseq_c ;


/**
 * Object encapsulating all parameters for creating, connecting and running all AMBA Advanced Extensible Interface
 * Stream agent (uvma_axis_agent_c) components.
 */
class uvma_axis_cfg_c extends uvml_cfg_c;
   
   // Generic options
   rand bit                      enabled          ; ///< 
   rand bit                      bypass_mode      ; ///< 
   rand uvm_active_passive_enum  is_active        ; ///< 
   rand uvml_reset_type_enum     reset_type       ; ///< 
   rand uvm_sequencer_arb_mode   sqr_arb_mode     ; ///< 
   rand bit                      cov_model_enabled; ///< 
   rand bit                      trn_log_enabled  ; ///< 
   
   // Protocol options
   rand uvma_axis_drv_mode_enum  drv_mode         ; ///< Operational mode
   rand uvma_axis_drv_idle_enum  drv_idle         ; ///< 
   rand int unsigned             drv_slv_valid_ton; ///< 
   rand int unsigned             drv_slv_idle_ton ; ///< 
   rand int unsigned             tdata_width      ; ///< Measured in bytes (B)
   rand int unsigned             tid_width        ; ///< Measured in bits  (b)
   rand int unsigned             tdest_width      ; ///< Measured in bits  (b)
   rand int unsigned             tuser_width      ; ///< Measured in bits  (b)
   
   // Sequence Types
   uvm_object_wrapper  mon_vseq_type     ; ///< 
   uvm_object_wrapper  idle_vseq_type    ; ///< 
   uvm_object_wrapper  mstr_drv_vseq_type; ///< 
   uvm_object_wrapper  slv_drv_vseq_type ; ///< 
   
   
   `uvm_object_utils_begin(uvma_axis_cfg_c)
      `uvm_field_int (                         enabled          , UVM_DEFAULT)
      `uvm_field_int (                         bypass_mode      , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active        , UVM_DEFAULT)
      `uvm_field_enum(uvml_reset_type_enum   , reset_type       , UVM_DEFAULT)
      `uvm_field_enum(uvm_sequencer_arb_mode , sqr_arb_mode     , UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled, UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled  , UVM_DEFAULT)
      
      `uvm_field_enum(uvma_axis_drv_mode_enum, drv_mode         , UVM_DEFAULT          )
      `uvm_field_enum(uvma_axis_drv_idle_enum, drv_idle         , UVM_DEFAULT          )
      `uvm_field_int (                         drv_slv_valid_ton, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                         drv_slv_idle_ton , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                         tdata_width      , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                         tid_width        , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                         tdest_width      , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int (                         tuser_width      , UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft enabled           == 1;
      soft is_active         == UVM_PASSIVE;
      soft sqr_arb_mode      == UVM_SEQ_ARB_FIFO;
      soft cov_model_enabled == 0;
      soft trn_log_enabled   == 1;
      
      soft tdata_width == uvma_axis_default_tdata_width;
      soft tid_width   == uvma_axis_default_tid_width  ;
      soft tdest_width == uvma_axis_default_tdest_width;
      soft tuser_width == uvma_axis_default_tuser_width;
      soft drv_idle    == UVMA_AXIS_DRV_IDLE_ZEROS;
   }
   
   constraint limits_cons {
      tdata_width  inside {[1:`UVMA_AXIS_TDATA_MAX_WIDTH ]};
      tid_width    inside {[0:`UVMA_AXIS_TID_MAX_WIDTH   ]};
      tdest_width  inside {[0:`UVMA_AXIS_TDEST_MAX_WIDTH ]};
      tuser_width  inside {[0:`UVMA_AXIS_TUSER_MAX_WIDTH ]};
      drv_slv_valid_ton inside {[0:100]};
      drv_slv_idle_ton  inside {[0:100]};
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_cfg");
   
endclass : uvma_axis_cfg_c


function uvma_axis_cfg_c::new(string name="uvma_axis_cfg");
   
   super.new(name);
   mon_vseq_type      = uvma_axis_mon_vseq_c     ::get_type();
   idle_vseq_type     = uvma_axis_idle_vseq_c    ::get_type();
   mstr_drv_vseq_type = uvma_axis_mstr_drv_vseq_c::get_type();
   slv_drv_vseq_type  = uvma_axis_slv_drv_vseq_c ::get_type();
   
endfunction : new


`endif // __UVMA_AXIS_CFG_SV__
