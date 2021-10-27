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


`ifndef __UVMA_AXIS_MON_SV__
`define __UVMA_AXIS_MON_SV__


/**
 * Component sampling transactions from the AMBA Advanced Extensible Interface Stream virtual interface (uvma_axis_if).
 */
class uvma_axis_mon_c extends uvml_mon_c;
   
   virtual uvma_axis_if.mon_mp  mp; ///< Handle to modport
   
   // Objects
   uvma_axis_cfg_c    cfg  ; ///< 
   uvma_axis_cntxt_c  cntxt; ///< 
   
   // TLM
   uvm_analysis_port#(uvma_axis_mstr_mon_trn_c)  mstr_ap; ///< 
   uvm_analysis_port#(uvma_axis_slv_mon_trn_c )  slv_ap ; ///< 
   
   
   `uvm_component_utils_begin(uvma_axis_mon_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_mon", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Oversees monitoring, depending on the reset state, by calling mon_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * Updates the context's reset state.
    */
   extern virtual task observe_reset();
   
   /**
    * Synchronous reset thread.
    */
   extern virtual task observe_reset_sync();
   
   /**
    * Asynchronous reset thread.
    */
   extern virtual task observe_reset_async();
   
   /**
    * Called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task mon_mstr_pre_reset();
   
   /**
    * Called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task mon_slv_pre_reset();
   
   /**
    * Called by run_phase() while agent is in reset state.
    */
   extern virtual task mon_mstr_in_reset();
   
   /**
    * Called by run_phase() while agent is in reset state.
    */
   extern virtual task mon_slv_in_reset();
   
   /**
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task mon_mstr_post_reset();
   
   /**
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task mon_slv_post_reset();
   
   /**
    * TODO Describe uvma_axis_mstr_mon_trn_c::sample_mstr_trn()
    */
   extern virtual task sample_mstr_trn(output uvma_axis_mstr_mon_trn_c trn);
   
   /**
    * TODO Describe uvma_axis_mstr_mon_trn_c::sample_slv_trn()
    */
   extern virtual task sample_slv_trn(output uvma_axis_slv_mon_trn_c trn);
   
   /**
    * TODO Describe uvma_axis_mon_c::process_mstr_trn()
    */
   extern virtual function void process_mstr_trn(ref uvma_axis_mstr_mon_trn_c trn);
   
   /**
    * TODO Describe uvma_axis_mon_c::process_slv_trn()
    */
   extern virtual function void process_slv_trn(ref uvma_axis_slv_mon_trn_c trn);
   
endclass : uvma_axis_mon_c


function uvma_axis_mon_c::new(string name="uvma_axis_mon", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_axis_mon_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_axis_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_axis_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   mp = cntxt.vif.mon_mp;
   mstr_ap = new("mstr_ap", this);
   slv_ap  = new("slv_ap" , this);
  
endfunction : build_phase


task uvma_axis_mon_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   if (cfg.enabled) begin
      fork
         observe_reset();
         
         begin : mstr
            forever begin
               case (cntxt.reset_state)
                  UVML_RESET_STATE_PRE_RESET : mon_mstr_pre_reset ();
                  UVML_RESET_STATE_IN_RESET  : mon_mstr_in_reset  ();
                  UVML_RESET_STATE_POST_RESET: mon_mstr_post_reset();
               endcase
            end
         end
         
         begin : slv
            forever begin
               case (cntxt.reset_state)
                  UVML_RESET_STATE_PRE_RESET : mon_slv_pre_reset ();
                  UVML_RESET_STATE_IN_RESET  : mon_slv_in_reset  ();
                  UVML_RESET_STATE_POST_RESET: mon_slv_post_reset();
               endcase
            end
         end
      join_none
   end
   
endtask : run_phase


task uvma_axis_mon_c::observe_reset();
   
   case (cfg.reset_type)
      UVML_RESET_TYPE_SYNCHRONOUS : observe_reset_sync ();
      UVML_RESET_TYPE_ASYNCHRONOUS: observe_reset_async();
      
      default: begin
         `uvm_fatal("AXIS_MON", $sformatf("Illegal cfg.reset_type: %s", cfg.reset_type.name()))
      end
   endcase
   
endtask : observe_reset


task uvma_axis_mon_c::observe_reset_sync();
   
   forever begin
      while (cntxt.vif.reset_n !== 1'b0) begin
         wait (cntxt.vif.clk === 1'b0);
         wait (cntxt.vif.clk === 1'b1);
      end
      cntxt.reset_state = UVML_RESET_STATE_IN_RESET;
      `uvm_info("AXIS_MON", "Entered IN_RESET state", UVM_MEDIUM)
      
      while (cntxt.vif.reset_n !== 1'b1) begin
         wait (cntxt.vif.clk === 1'b0);
         wait (cntxt.vif.clk === 1'b1);
      end
      cntxt.reset_state = UVML_RESET_STATE_POST_RESET;
      `uvm_info("AXIS_MON", "Entered POST_RESET state", UVM_MEDIUM)
   end
   
endtask : observe_reset_sync


task uvma_axis_mon_c::observe_reset_async();
   
   forever begin
      wait (cntxt.vif.reset_n === 1'b0);
      cntxt.reset_state = UVML_RESET_STATE_IN_RESET;
      `uvm_info("AXIS_MON", "Entered IN_RESET state", UVM_MEDIUM)
      
      wait (cntxt.vif.reset_n === 1'b1);
      cntxt.reset_state = UVML_RESET_STATE_POST_RESET;
      `uvm_info("AXIS_MON", "Entered POST_RESET state", UVM_MEDIUM)
   end
   
endtask : observe_reset_async


task uvma_axis_mon_c::mon_mstr_pre_reset();
   
   @(mp.mon_cb);
   
endtask : mon_mstr_pre_reset


task uvma_axis_mon_c::mon_slv_pre_reset();
   
   @(mp.mon_cb);
   
endtask : mon_slv_pre_reset


task uvma_axis_mon_c::mon_mstr_in_reset();
   
   @(mp.mon_cb);
   
endtask : mon_mstr_in_reset


task uvma_axis_mon_c::mon_slv_in_reset();
   
   @(mp.mon_cb);
   
endtask : mon_slv_in_reset


task uvma_axis_mon_c::mon_mstr_post_reset();
   
   uvma_axis_mstr_mon_trn_c  trn;
   
   sample_mstr_trn (trn);
   process_mstr_trn(trn);
   mstr_ap.write   (trn);
   
endtask : mon_mstr_post_reset


task uvma_axis_mon_c::mon_slv_post_reset();
   
   uvma_axis_slv_mon_trn_c  trn;
   
   sample_slv_trn (trn);
   process_slv_trn(trn);
   slv_ap.write   (trn);
   
endtask : mon_slv_post_reset


task uvma_axis_mon_c::sample_mstr_trn(output uvma_axis_mstr_mon_trn_c trn);
   
   @(mp.mon_cb);
   trn = uvma_axis_mstr_mon_trn_c::type_id::create("trn");
   
   trn.tvalid = mp.mon_cb.tvalid;
   trn.tlast  = mp.mon_cb.tlast ;
   
   for (int unsigned ii=0; ii<cfg.tdata_width; ii++) begin
      trn.tdata[ii] = mp.mon_cb.tdata[ii];
   end
   for (int unsigned ii=0; ii<cfg.tdata_width; ii++) begin
      trn.tstrb[ii] = mp.mon_cb.tstrb[ii];
   end
   for (int unsigned ii=0; ii<cfg.tdata_width; ii++) begin
      trn.tkeep[ii] = mp.mon_cb.tkeep[ii];
   end
   for (int unsigned ii=0; ii<cfg.tid_width; ii++) begin
      trn.tid[ii] = mp.mon_cb.tid[ii];
   end
   for (int unsigned ii=0; ii<cfg.tdest_width; ii++) begin
      trn.tdest[ii] = mp.mon_cb.tdest[ii];
   end
   for (int unsigned ii=0; ii<cfg.tuser_width; ii++) begin
      trn.tuser[ii] = mp.mon_cb.tuser[ii];
   end
   
endtask : sample_mstr_trn


task uvma_axis_mon_c::sample_slv_trn(output uvma_axis_slv_mon_trn_c trn);
   
   @(mp.mon_cb);
   trn = uvma_axis_slv_mon_trn_c::type_id::create("trn");
   trn.tready = mp.mon_cb.tready;
   
endtask : sample_slv_trn


function void uvma_axis_mon_c::process_mstr_trn(ref uvma_axis_mstr_mon_trn_c trn);
   
   trn.cfg = cfg;
   trn.set_initiator(this);
   trn.set_timestamp_end($realtime());
   `uvm_info("AXIS_MON", $sformatf("Sampled MSTR transaction from the virtual interface:\n%s", trn.sprint()), UVM_HIGH)
   
endfunction : process_mstr_trn


function void uvma_axis_mon_c::process_slv_trn(ref uvma_axis_slv_mon_trn_c trn);
   
   trn.cfg = cfg;
   trn.set_initiator(this);
   trn.set_timestamp_end($realtime());
   `uvm_info("AXIS_MON", $sformatf("Sampled MSTR transaction from the virtual interface:\n%s", trn.sprint()), UVM_HIGH)
   
endfunction : process_slv_trn


`endif // __UVMA_AXIS_MON_SV__
