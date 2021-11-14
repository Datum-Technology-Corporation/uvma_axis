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


`ifndef __UVME_AXIS_ST_ENV_SV__
`define __UVME_AXIS_ST_ENV_SV__


/**
 * Top-level component that encapsulates, builds and connects all other AMBA Advanced Extensible Interface Stream
 * environment components.
 */
class uvme_axis_st_env_c extends uvml_env_c;
   
   // Objects
   uvme_axis_st_cfg_c    cfg  ; ///< 
   uvme_axis_st_cntxt_c  cntxt; ///< 
   
   // Agents
   uvma_axis_agent_c  mstr_agent; ///< 
   uvma_axis_agent_c  slv_agent ; ///< 
   
   // Components
   uvme_axis_st_cov_model_c             cov_model ; ///< 
   uvme_axis_st_prd_c                   predictor ; ///< 
   uvme_axis_st_sb_simplex_c            sb_mstr   ; ///< 
   uvme_axis_st_sb_simplex_c            sb_e2e    ; ///< 
   uvme_axis_st_vsqr_c                  vsequencer; ///< 
   uvml_delay_c #(uvma_axis_mon_trn_c)  mstr_delay; ///< 
   uvml_delay_c #(uvma_axis_mon_trn_c)  e2e_delay ; ///< 
   
   
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
   
endclass : uvme_axis_st_env_c


function uvme_axis_st_env_c::new(string name="uvme_axis_st_env", uvm_component parent=null);
   
   super.new(name, parent);
   
   set_type_override_by_type(
      uvma_axis_cov_model_c   ::get_type(),
      uvme_axis_st_cov_model_c::get_type(),
   );
   
endfunction : new


function void uvme_axis_st_env_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_axis_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   else begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
   end
   
   if (cfg.enabled) begin
      void'(uvm_config_db#(uvme_axis_st_cntxt_c)::get(this, "", "cntxt", cntxt));
      if (cntxt == null) begin
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
   end
   
endfunction: connect_phase


function void uvme_axis_st_env_c::assign_cfg();
   
   uvm_config_db#(uvme_axis_st_cfg_c   )::set(this, "*"         , "cfg", cfg            );
   uvm_config_db#(uvma_axis_cfg_c      )::set(this, "mstr_agent", "cfg", cfg.mstr_cfg   );
   uvm_config_db#(uvma_axis_cfg_c      )::set(this, "slv_agent" , "cfg", cfg.slv_cfg    );
   uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "sb_mstr"   , "cfg", cfg.sb_mstr_cfg);
   uvm_config_db#(uvml_sb_simplex_cfg_c)::set(this, "sb_e2e"    , "cfg", cfg.sb_e2e_cfg );
   
endfunction: assign_cfg


function void uvme_axis_st_env_c::assign_cntxt();
   
   uvm_config_db#(uvme_axis_st_cntxt_c   )::set(this, "*"         , "cntxt", cntxt              );
   uvm_config_db#(uvma_axis_cntxt_c      )::set(this, "mstr_agent", "cntxt", cntxt.mstr_cntxt   );
   uvm_config_db#(uvma_axis_cntxt_c      )::set(this, "slv_agent" , "cntxt", cntxt.slv_cntxt    );
   uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "sb_mstr"   , "cntxt", cntxt.sb_mstr_cntxt);
   uvm_config_db#(uvml_sb_simplex_cntxt_c)::set(this, "sb_e2e"    , "cntxt", cntxt.sb_e2e_cntxt );
   
endfunction: assign_cntxt


function void uvme_axis_st_env_c::create_agents();
   
   mstr_agent = uvma_axis_agent_c::type_id::create("mstr_agent", this);
   slv_agent  = uvma_axis_agent_c::type_id::create("slv_agent" , this);
   
endfunction: create_agents


function void uvme_axis_st_env_c::create_env_components();
   
   if (cfg.scoreboarding_enabled) begin
      predictor  = uvme_axis_st_prd_c                 ::type_id::create("predictor" , this);
      sb_mstr    = uvme_axis_st_sb_simplex_c          ::type_id::create("sb_mstr"   , this);
      sb_e2e     = uvme_axis_st_sb_simplex_c          ::type_id::create("sb_e2e"    , this);
      mstr_delay = uvml_delay_c #(uvma_axis_mon_trn_c)::type_id::create("mstr_delay", this);
      e2e_delay  = uvml_delay_c #(uvma_axis_mon_trn_c)::type_id::create("e2e_delay" , this);
   end
   
endfunction: create_env_components


function void uvme_axis_st_env_c::create_vsequencer();
   
   vsequencer = uvme_axis_st_vsqr_c::type_id::create("vsequencer", this);
   
endfunction: create_vsequencer


function void uvme_axis_st_env_c::connect_predictor();
   
   // Connect agent -> predictor
   mstr_agent.seq_item_ap.connect(predictor.mstr_in_export);
   mstr_agent.mon_trn_ap .connect(predictor.e2e_in_export );
   
endfunction: connect_predictor


function void uvme_axis_st_env_c::connect_scoreboard();
   
   // Connect agent -> scoreboard
   mstr_agent.mon_trn_ap.connect(mstr_delay.in_export );
   slv_agent .mon_trn_ap.connect(e2e_delay .in_export );
   e2e_delay .out_ap    .connect(sb_e2e    .act_export);
   mstr_delay.out_ap    .connect(sb_mstr   .act_export);
   
   e2e_delay .set_duration(1000);
   mstr_delay.set_duration(1000);
   
   // Connect predictor -> scoreboard
   predictor.e2e_out_ap .connect(sb_e2e .exp_export);
   predictor.mstr_out_ap.connect(sb_mstr.exp_export);
   
endfunction: connect_scoreboard


function void uvme_axis_st_env_c::assemble_vsequencer();
   
   vsequencer.mstr_vsequencer = mstr_agent.vsequencer;
   vsequencer.slv_vsequencer  = slv_agent .vsequencer;
   
endfunction: assemble_vsequencer


`endif // __UVME_AXIS_ST_ENV_SV__
