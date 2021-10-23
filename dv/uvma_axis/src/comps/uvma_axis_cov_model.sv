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


`ifndef __UVMA_AXIS_COV_MODEL_SV__
`define __UVMA_AXIS_COV_MODEL_SV__


/**
 * Component encapsulating AMBA Advanced Extensible Interface Stream functional coverage model.
 */
class uvma_axis_cov_model_c extends uvm_component;
   
   // Objects
   uvma_axis_cfg_c       cfg  ; ///< 
   uvma_axis_cntxt_c     cntxt; ///< 
   
   // Covergroup variables
   uvma_axis_mon_trn_c        mon_trn      ; ///< 
   uvma_axis_seq_item_c       seq_item     ; ///< 
   uvma_axis_mstr_mon_trn_c   mstr_mon_trn ; ///< 
   uvma_axis_mstr_seq_item_c  mstr_seq_item; ///< 
   uvma_axis_slv_mon_trn_c    slv_mon_trn  ; ///< 
   uvma_axis_slv_seq_item_c   slv_seq_item ; ///< 
   
   // TLM
   uvm_tlm_analysis_fifo#(uvma_axis_mon_trn_c      )  mon_trn_fifo      ; ///< 
   uvm_tlm_analysis_fifo#(uvma_axis_seq_item_c     )  seq_item_fifo     ; ///< 
   uvm_tlm_analysis_fifo#(uvma_axis_mstr_mon_trn_c )  mstr_mon_trn_fifo ; ///< 
   uvm_tlm_analysis_fifo#(uvma_axis_mstr_seq_item_c)  mstr_seq_item_fifo; ///< 
   uvm_tlm_analysis_fifo#(uvma_axis_slv_mon_trn_c  )  slv_mon_trn_fifo  ; ///< 
   uvm_tlm_analysis_fifo#(uvma_axis_slv_seq_item_c )  slv_seq_item_fifo ; ///< 
   
   
   `uvm_component_utils_begin(uvma_axis_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_cov_model", uvm_component parent=null);
   
   ///**
   // * 1. Ensures cfg & cntxt handles are not null.
   // * 2. Builds fifos.
   // */
   //extern virtual function void build_phase(uvm_phase phase);
   //
   ///**
   // * Forks all sampling loops
   // */
   //extern virtual task run_phase(uvm_phase phase);
   //
   ///**
   // * TODO Describe uvma_axis_cov_model_c::sample_cfg()
   // */
   //extern virtual function void sample_cfg();
   //
   ///**
   // * TODO Describe uvma_axis_cov_model_c::sample_cntxt()
   // */
   //extern virtual function void sample_cntxt();
   //
   ///**
   // * TODO Describe uvma_axis_cov_model_c::sample_mon_trn()
   // */
   //extern virtual function void sample_mon_trn();
   //
   ///**
   // * TODO Describe uvma_axis_cov_model_c::sample_seq_item()
   // */
   //extern virtual function void sample_seq_item();
   //
   ///**
   // * TODO Describe uvma_axis_cov_model_c::sample_mstr_mon_trn()
   // */
   //extern virtual function void sample_mstr_mon_trn();
   //
   ///**
   // * TODO Describe uvma_axis_cov_model_c::sample_mstr_seq_item()
   // */
   //extern virtual function void sample_mstr_seq_item();
   //
   ///**
   // * TODO Describe uvma_axis_cov_model_c::sample_slv_mon_trn()
   // */
   //extern virtual function void sample_slv_mon_trn();
   //
   ///**
   // * TODO Describe uvma_axis_cov_model_c::sample_slv_seq_item()
   // */
   //extern virtual function void sample_slv_seq_item();
   
endclass : uvma_axis_cov_model_c


function uvma_axis_cov_model_c::new(string name="uvma_axis_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


//function void uvma_axis_cov_model_c::build_phase(uvm_phase phase);
//   
//   super.build_phase(phase);
//   
//   void'(uvm_config_db#(uvma_axis_cfg_c)::get(this, "", "cfg", cfg));
//   if (cfg == null) begin
//      `uvm_fatal("CFG", "Configuration handle is null")
//   end
//   
//   void'(uvm_config_db#(uvma_axis_cntxt_c)::get(this, "", "cntxt", cntxt));
//   if (cntxt == null) begin
//      `uvm_fatal("CNTXT", "Context handle is null")
//   end
//   
//   mon_trn_fifo       = new("mon_trn_fifo"      , this);
//   seq_item_fifo      = new("seq_item_fifo"     , this);
//   mstr_mon_trn_fifo  = new("mstr_mon_trn_fifo" , this);
//   mstr_seq_item_fifo = new("mstr_seq_item_fifo", this);
//   slv_mon_trn_fifo   = new("slv_mon_trn_fifo"  , this);
//   slv_seq_item_fifo  = new("slv_seq_item_fifo" , this);
//   
//endfunction : build_phase
//
//
//task uvma_axis_cov_model_c::run_phase(uvm_phase phase);
//   
//   super.run_phase(phase);
//   
//   if (cfg.enabled && cfg.cov_model_enabled) begin
//      fork
//         // Configuration
//         forever begin
//            cntxt.sample_cfg_e.wait_trigger();
//            sample_cfg();
//         end
//         
//         // Context
//         forever begin
//            cntxt.sample_cntxt_e.wait_trigger();
//            sample_cntxt();
//         end
//         
//         // Monitor transactions
//         forever begin
//            mon_trn_fifo.get(mon_trn);
//            sample_mon_trn();
//         end
//         
//         // Sequence items
//         forever begin
//            seq_item_fifo.get(seq_item);
//            sample_seq_item();
//         end
//         
//         // Monitor mstr transactions
//         forever begin
//            mstr_mon_trn_fifo.get(mstr_mon_trn);
//            sample_mstr_mon_trn();
//         end
//         
//         // Sequence mstr items
//         forever begin
//            mstr_seq_item_fifo.get(mstr_seq_item);
//            sample_mstr_seq_item();
//         end
//         
//         // Monitor slv transactions
//         forever begin
//            slv_mon_trn_fifo.get(slv_mon_trn);
//            sample_slv_mon_trn();
//         end
//         
//         // Sequence slv items
//         forever begin
//            slv_seq_item_fifo.get(slv_seq_item);
//            sample_slv_seq_item();
//         end
//      join_none
//   end
//   
//endtask : run_phase
//
//
//function void uvma_axis_cov_model_c::sample_cfg();
//   
//   // TODO Implement uvma_axis_cov_model_c::sample_cfg();
//   
//endfunction : sample_cfg
//
//
//function void uvma_axis_cov_model_c::sample_cntxt();
//   
//   // TODO Implement uvma_axis_cov_model_c::sample_cntxt();
//   
//endfunction : sample_cntxt
//
//
//function void uvma_axis_cov_model_c::sample_mon_trn();
//   
//   // TODO Implement uvma_axis_cov_model_c::sample_mon_trn();
//   
//endfunction : sample_mon_trn
//
//
//function void uvma_axis_cov_model_c::sample_seq_item();
//   
//   // TODO Implement uvma_axis_cov_model_c::sample_seq_item();
//   
//endfunction : sample_seq_item
//
//
//function void uvma_axis_cov_model_c::sample_mstr_mon_trn();
//   
//   // TODO Implement uvma_axis_cov_model_c::sample_mstr_mon_trn();
//   
//endfunction : sample_mstr_mon_trn
//
//
//function void uvma_axis_cov_model_c::sample_mstr_seq_item();
//   
//   // TODO Implement uvma_axis_cov_model_c::sample_mstr_seq_item();
//   
//endfunction : sample_mstr_seq_item
//
//
//function void uvma_axis_cov_model_c::sample_slv_mon_trn();
//   
//   // TODO Implement uvma_axis_cov_model_c::sample_slv_mon_trn();
//   
//endfunction : sample_slv_mon_trn
//
//
//function void uvma_axis_cov_model_c::sample_slv_seq_item();
//   
//   // TODO Implement uvma_axis_cov_model_c::sample_slv_seq_item();
//   
//endfunction : sample_slv_seq_item


`endif // __UVMA_AXIS_COV_MODEL_SV__
