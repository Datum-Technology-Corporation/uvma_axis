// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVME_AXIS_ST_ENV_SV__
`define __UVME_AXIS_ST_ENV_SV__


/**
 * Top-level component that encapsulates, builds and connects all other
 * AMBA Advanced Extensible Interface Stream environment components.
 */
class uvme_axis_st_env_c extends uvm_env;
   
   // Objects
   uvme_axis_st_cfg_c    cfg;
   uvme_axis_st_cntxt_c  cntxt;
   
   // Agents
   uvma_axis_agent_c  master_agent;
   uvma_axis_agent_c  slave_agent ;
   
   // Components
   uvme_axis_st_cov_model_c   cov_model;
   uvme_axis_st_prd_c         predictor;
   uvme_axis_st_sb_simplex_c  sb;
   uvme_axis_st_vsqr_c        vsequencer;
   
   
   `uvm_component_utils_begin(uvme_axis_st_env_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_axis_st_env", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null
    * 2. Retrieves cntxt.clk_vif from UVM configuration database via retrieve_clk_vif()
    * 3. Assigns cfg and cntxt handles via assign_cfg() & assign_cntxt()
    * 4. Builds all components via create_<x>()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * 1. Connects agents to predictor via connect_predictor()
    * 2. Connects predictor & agents to scoreboard via connect_scoreboard()
    * 3. Assembles virtual sequencer handles via assemble_vsequencer()
    * 4. Connects agents to coverage model via connect_coverage_model()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * Assigns configuration handles to components using UVM Configuration Database.
    */
   extern virtual function void assign_cfg();
   
   /**
    * Assigns context handles to components using UVM Configuration Database.
    */
   extern virtual function void assign_cntxt();
   
   /**
    * Creates agent components.
    */
   extern virtual function void create_agents();
   
   /**
    * Creates additional (non-agent) environment components (and objects).
    */
   extern virtual function void create_env_components();
   
   /**
    * Creates environment's virtual sequencer.
    */
   extern virtual function void create_vsequencer();
   
   /**
    * Creates environment's coverage model.
    */
   extern virtual function void create_cov_model();
   
   /**
    * Connects agents to predictor.
    */
   extern virtual function void connect_predictor();
   
   /**
    * Connects scoreboards components to agents/predictor.
    */
   extern virtual function void connect_scoreboard();
   
   /**
    * Assembles virtual sequencer from agent sequencers.
    */
   extern virtual function void assemble_vsequencer();
   
   /**
    * Connects environment coverage model to agents/scoreboards/predictor.
    */
   extern virtual function void connect_coverage_model();
   
endclass : uvme_axis_st_env_c


function uvme_axis_st_env_c::new(string name="uvme_axis_st_env", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_axis_st_env_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_axis_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   else begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
   end
   
   if (cfg.enabled) begin
      void'(uvm_config_db#(uvme_axis_st_cntxt_c)::get(this, "", "cntxt", cntxt));
      if (!cntxt) begin
         `uvm_info("CNTXT", "Context handle is null; creating.", UVM_DEBUG)
         cntxt = uvme_axis_st_cntxt_c::type_id::create("cntxt");
      end
      
      assign_cfg           ();
      assign_cntxt         ();
      create_agents        ();
      create_env_components();
      
      if (cfg.is_active) begin
         create_vsequencer();
      end
      
      if (cfg.cov_model_enabled) begin
         create_cov_model();
      end
   end
   
endfunction : build_phase


function void uvme_axis_st_env_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   if (cfg.enabled) begin
      if (cfg.scoreboarding_enabled) begin
         connect_predictor ();
         connect_scoreboard();
      end
      
      if (cfg.is_active) begin
         assemble_vsequencer();
      end
      
      if (cfg.cov_model_enabled) begin
         connect_coverage_model();
      end
   end
   
endfunction: connect_phase


function void uvme_axis_st_env_c::assign_cfg();
   
   uvm_config_db#(uvme_axis_st_cfg_c)::set(this, "*"           , "cfg", cfg           );
   uvm_config_db#(uvma_axis_cfg_c   )::set(this, "master_agent", "cfg", cfg.master_cfg);
   uvm_config_db#(uvma_axis_cfg_c   )::set(this, "slave_agent" , "cfg", cfg.slave_cfg );
   uvm_config_db#(uvml_sb_cfg_c     )::set(this, "sb"          , "cfg", cfg.sb_cfg    );
   
endfunction: assign_cfg


function void uvme_axis_st_env_c::assign_cntxt();
   
   uvm_config_db#(uvme_axis_st_cntxt_c)::set(this, "*"           , "cntxt", cntxt             );
   uvm_config_db#(uvma_axis_cntxt_c   )::set(this, "master_agent", "cntxt", cntxt.master_cntxt);
   uvm_config_db#(uvma_axis_cntxt_c   )::set(this, "slave_agent" , "cntxt", cntxt.slave_cntxt );
   uvm_config_db#(uvml_sb_cntxt_c     )::set(this, "sb"           , "cntxt", cntxt.sb_cntxt   );
   
endfunction: assign_cntxt


function void uvme_axis_st_env_c::create_agents();
   
   master_agent = uvma_axis_agent_c::type_id::create("master_agent", this);
   slave_agent  = uvma_axis_agent_c::type_id::create("slave_agent" , this);
   
endfunction: create_agents


function void uvme_axis_st_env_c::create_env_components();
   
   if (cfg.scoreboarding_enabled) begin
      predictor = uvme_axis_st_prd_c       ::type_id::create("predictor", this);
      sb        = uvme_axis_st_sb_simplex_c::type_id::create("sb"       , this);
   end
   
endfunction: create_env_components


function void uvme_axis_st_env_c::create_vsequencer();
   
   vsequencer = uvme_axis_st_vsqr_c::type_id::create("vsequencer", this);
   
endfunction: create_vsequencer


function void uvme_axis_st_env_c::create_cov_model();
   
   cov_model = uvme_axis_st_cov_model_c::type_id::create("cov_model", this);
   
endfunction: create_cov_model


function void uvme_axis_st_env_c::connect_predictor();
   
   // Connect agent -> predictor
   master_agent.mon_ap.connect(predictor.in_export);
   
endfunction: connect_predictor


function void uvme_axis_st_env_c::connect_scoreboard();
   
   // Connect agent -> scoreboard
   slave_agent.mon_ap.connect(sb.act_export);
   
   // Connect predictor -> scoreboard
   predictor.out_ap.connect(sb.exp_export);
   
endfunction: connect_scoreboard


function void uvme_axis_st_env_c::assemble_vsequencer();
   
   vsequencer.master_sequencer = master_agent.sequencer;
   
endfunction: assemble_vsequencer


function void uvme_axis_st_env_c::connect_coverage_model();
   
   master_agent.drv_ap.connect(cov_model.master_seq_item_export);
   master_agent.mon_ap.connect(cov_model.master_mon_trn_export );
   slave_agent .mon_ap.connect(cov_model.slave_mon_trn_export  );
   
endfunction: connect_coverage_model


`endif // __UVME_AXIS_ST_ENV_SV__
