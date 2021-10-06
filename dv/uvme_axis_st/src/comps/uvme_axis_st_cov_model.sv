// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_AXIS_ST_COV_MODEL_SV__
`define __UVME_AXIS_ST_COV_MODEL_SV__


/**
 * Component encapsulating AMBA Advanced Extensible Interface Stream Self-Test Environment functional
 * coverage model.
 */
class uvme_axis_st_cov_model_c extends uvm_component;
   
   // Coverage targets
   uvme_axis_st_cfg_c    cfg;
   uvme_axis_st_cntxt_c  cntxt;
   uvma_axis_seq_item_c  master_seq_item;
   uvma_axis_mon_trn_c   master_mon_trn;
   uvma_axis_mon_trn_c   slave_mon_trn;
   
   // TLM
   uvm_analysis_export  #(uvma_axis_seq_item_c)  master_seq_item_export;
   uvm_analysis_export  #(uvma_axis_mon_trn_c )  master_mon_trn_export ;
   uvm_analysis_export  #(uvma_axis_mon_trn_c )  slave_mon_trn_export ;
   uvm_tlm_analysis_fifo#(uvma_axis_seq_item_c)  master_seq_item_fifo  ;
   uvm_tlm_analysis_fifo#(uvma_axis_mon_trn_c )  master_mon_trn_fifo   ;
   uvm_tlm_analysis_fifo#(uvma_axis_mon_trn_c )  slave_mon_trn_fifo   ;
   
   
   `uvm_component_utils_begin(uvme_axis_st_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   covergroup axis_st_cfg_cg;
      // TODO Implement axis_st_cfg_cg
      //      Ex: abc_cpt : coverpoint cfg.abc;
      //          xyz_cpt : coverpoint cfg.xyz;
   endgroup : axis_st_cfg_cg
   
   covergroup axis_st_cntxt_cg;
      // TODO Implement axis_st_cntxt_cg
      //      Ex: abc_cpt : coverpoint cntxt.abc;
      //          xyz_cpt : coverpoint cntxt.xyz;
   endgroup : axis_st_cntxt_cg
   
   covergroup axis_st_master_seq_item_cg;
      // TODO Implement axis_st_master_seq_item_cg
      //      Ex: abc_cpt : coverpoint master_seq_item.abc;
      //          xyz_cpt : coverpoint master_seq_item.xyz;
   endgroup : axis_st_master_seq_item_cg
   
   covergroup axis_st_master_mon_trn_cg;
      // TODO Implement axis_st_master_mon_trn_cg
      //      Ex: abc_cpt : coverpoint master_mon_trn.abc;
      //          xyz_cpt : coverpoint master_mon_trn.xyz;
   endgroup : axis_st_master_mon_trn_cg
   
   covergroup axis_st_slave_mon_trn_cg;
      // TODO Implement axis_st_slave_mon_trn_cg
      //      Ex: abc_cpt : coverpoint slave_mon_trn.abc;
      //          xyz_cpt : coverpoint slave_mon_trn.xyz;
   endgroup : axis_st_slave_mon_trn_cg
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_axis_st_cov_model", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * Describe uvme_axis_st_cov_model_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_cfg()
    */
   extern virtual function void sample_cfg();
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_cntxt()
    */
   extern virtual function void sample_cntxt();
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_master_seq_item()
    */
   extern virtual function void sample_master_seq_item();
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_master_mon_trn()
    */
   extern virtual function void sample_master_mon_trn();
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_slave_mon_trn()
    */
   extern virtual function void sample_slave_mon_trn();
   
endclass : uvme_axis_st_cov_model_c


function uvme_axis_st_cov_model_c::new(string name="uvme_axis_st_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_axis_st_cov_model_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_axis_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_axis_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // Build TLM objects
   master_mon_trn_export = new("master_mon_trn_export", this);
   slave_mon_trn_export = new("slave_mon_trn_export", this);
   master_mon_trn_fifo   = new("master_mon_trn_fifo"  , this);
   slave_mon_trn_fifo   = new("slave_mon_trn_fifo"  , this);
   
endfunction : build_phase


function void uvme_axis_st_cov_model_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   master_mon_trn_export.connect(master_mon_trn_fifo.analysis_export);
   slave_mon_trn_export.connect(slave_mon_trn_fifo.analysis_export);
   
endfunction : connect_phase


task uvme_axis_st_cov_model_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
  
  fork
    // Configuration
    forever begin
      cntxt.sample_cfg_e.wait_trigger();
      sample_cfg();
    end
    
    // Context
    forever begin
      cntxt.sample_cntxt_e.wait_trigger();
      sample_cntxt();
    end
    
    // master sequence item coverage
    forever begin
       master_seq_item_fifo.get(master_seq_item);
       sample_master_seq_item();
    end
    
    // master monitored transaction coverage
    forever begin
       master_mon_trn_fifo.get(master_mon_trn);
       sample_master_mon_trn();
    end
    
    // slave monitored transaction coverage
    forever begin
       slave_mon_trn_fifo.get(slave_mon_trn);
       sample_slave_mon_trn();
    end
  join_none
   
endtask : run_phase


function void uvme_axis_st_cov_model_c::sample_cfg();
   
  axis_st_cfg_cg.sample();
   
endfunction : sample_cfg


function void uvme_axis_st_cov_model_c::sample_cntxt();
   
   axis_st_cntxt_cg.sample();
   
endfunction : sample_cntxt


function void uvme_axis_st_cov_model_c::sample_master_seq_item();
   
   axis_st_master_seq_item_cg.sample();
   
endfunction : sample_master_seq_item


function void uvme_axis_st_cov_model_c::sample_master_mon_trn();
   
   axis_st_master_mon_trn_cg.sample();
   
endfunction : sample_master_mon_trn


function void uvme_axis_st_cov_model_c::sample_slave_mon_trn();
   
   axis_st_slave_mon_trn_cg.sample();
   
endfunction : sample_slave_mon_trn


`endif // __UVME_AXIS_ST_COV_MODEL_SV__
