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


`ifndef __UVMA_AXIS_LOGGER_SV__
`define __UVMA_AXIS_LOGGER_SV__


/**
 * TODO Describe uvma_axis_logger_c
 */
class uvma_axis_logger_c extends uvm_component;
   
   // Objects
   uvma_axis_cfg_c   cfg  ; ///< 
   uvma_axis_cntxt_c cntxt; ///< 
   
   // Components
   uvml_logs_metadata_logger_c #(uvma_axis_mon_trn_c      )  mon_trn_logger      ; ///< 
   uvml_logs_metadata_logger_c #(uvma_axis_seq_item_c     )  seq_item_logger     ; ///< 
   uvml_logs_metadata_logger_c #(uvma_axis_mstr_mon_trn_c )  mstr_mon_trn_logger ; ///< 
   uvml_logs_metadata_logger_c #(uvma_axis_slv_mon_trn_c  )  slv_mon_trn_logger  ; ///< 
   uvml_logs_metadata_logger_c #(uvma_axis_mstr_seq_item_c)  mstr_seq_item_logger; ///< 
   uvml_logs_metadata_logger_c #(uvma_axis_slv_seq_item_c )  slv_seq_item_logger ; ///< 
   
   // TLM
   uvm_analysis_export #(uvma_axis_mon_trn_c      )  mon_trn_logger_export      ; ///< 
   uvm_analysis_export #(uvma_axis_seq_item_c     )  seq_item_logger_export     ; ///< 
   uvm_analysis_export #(uvma_axis_mstr_mon_trn_c )  mstr_mon_trn_logger_export ; ///< 
   uvm_analysis_export #(uvma_axis_slv_mon_trn_c  )  slv_mon_trn_logger_export  ; ///< 
   uvm_analysis_export #(uvma_axis_mstr_seq_item_c)  mstr_seq_item_logger_export; ///< 
   uvm_analysis_export #(uvma_axis_slv_seq_item_c )  slv_seq_item_logger_export ; ///< 
   
   
   `uvm_component_utils_begin(uvma_axis_logger_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_logger", uvm_component parent=null);
   
   /**
    * TODO Describe uvma_axis_logger_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_axis_logger_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
endclass : uvma_axis_logger_c


function uvma_axis_logger_c::new(string name="uvma_axis_logger", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_axis_logger_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_axis_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_axis_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   mon_trn_logger       = uvml_logs_metadata_logger_c #(uvma_axis_mon_trn_c      )::type_id::create("mon_trn_logger"      , this);
   seq_item_logger      = uvml_logs_metadata_logger_c #(uvma_axis_seq_item_c     )::type_id::create("seq_item_logger"     , this);
   mstr_mon_trn_logger  = uvml_logs_metadata_logger_c #(uvma_axis_mstr_mon_trn_c )::type_id::create("mstr_mon_trn_logger" , this);
   slv_mon_trn_logger   = uvml_logs_metadata_logger_c #(uvma_axis_slv_mon_trn_c  )::type_id::create("slv_mon_trn_logger"  , this);
   mstr_seq_item_logger = uvml_logs_metadata_logger_c #(uvma_axis_mstr_seq_item_c)::type_id::create("mstr_seq_item_logger", this);
   slv_seq_item_logger  = uvml_logs_metadata_logger_c #(uvma_axis_slv_seq_item_c )::type_id::create("slv_seq_item_logger" , this);
   
endfunction : build_phase


function void uvma_axis_logger_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   mon_trn_logger      .set_file_name("mon_trn"      );
   seq_item_logger     .set_file_name("seq_item"     );
   mstr_mon_trn_logger .set_file_name("mstr.mon_trn" );
   slv_mon_trn_logger  .set_file_name("slv.mon_trn"  );
   mstr_seq_item_logger.set_file_name("mstr.seq_item");
   slv_seq_item_logger .set_file_name("slv.seq_item" );
   
   mon_trn_logger_export       = mon_trn_logger      .analysis_export;
   seq_item_logger_export      = seq_item_logger     .analysis_export;
   mstr_mon_trn_logger_export  = mstr_mon_trn_logger .analysis_export;
   slv_mon_trn_logger_export   = slv_mon_trn_logger  .analysis_export;
   mstr_seq_item_logger_export = mstr_seq_item_logger.analysis_export;
   slv_seq_item_logger_export  = slv_seq_item_logger .analysis_export;
   
endfunction : connect_phase


`endif // __UVMA_AXIS_LOGGER_SV__
