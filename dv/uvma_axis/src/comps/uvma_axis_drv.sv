// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_DRV_SV__
`define __UVMA_AXIS_DRV_SV__


/**
 * Component driving a AMBA Advanced Extensible Interface Stream virtual interface (uvma_axis_if).
 */
class uvma_axis_drv_c extends uvm_driver#(
   .REQ(uvma_axis_cycle_seq_item_c),
   .RSP(uvma_axis_cycle_seq_item_c)
);
   
   // Objects
   uvma_axis_cfg_c    cfg;
   uvma_axis_cntxt_c  cntxt;
   
   // TLM
   uvm_analysis_port#(uvma_axis_cycle_seq_item_c)  ap;
   
   
   `uvm_component_utils_begin(uvma_axis_drv_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_drv", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Oversees driving, depending on the reset state, by calling drv_<pre|in|post>_reset() tasks.
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * Called by run_phase() while agent is in pre-reset state.
    */
   extern virtual task drv_pre_reset(uvm_phase phase);
   
   /**
    * Called by run_phase() while agent is in reset state.
    */
   extern virtual task drv_in_reset(uvm_phase phase);
   
   /**
    * Called by run_phase() while agent is in post-reset state.
    */
   extern virtual task drv_post_reset(uvm_phase phase);
   
   /**
    * Drives the virtual interface's (cntxt.vif) signals using req's contents.
    */
   extern virtual task drv_mstr_req(ref uvma_axis_cycle_seq_item_c req);
   
   /**
    * Drives the virtual interface's (cntxt.vif) signals using req's contents.
    */
   extern virtual task drv_slv_req(ref uvma_axis_cycle_seq_item_c req);
   
   /**
    * Drives the virtual interface's (cntxt.vif) signals during and idle cycle.
    */
   extern virtual task drv_mstr_idle();
   
endclass : uvma_axis_drv_c


function uvma_axis_drv_c::new(string name="uvma_axis_drv", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_axis_drv_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_axis_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   uvm_config_db#(uvma_axis_cfg_c)::set(this, "*", "cfg", cfg);
   
   void'(uvm_config_db#(uvma_axis_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   uvm_config_db#(uvma_axis_cntxt_c)::set(this, "*", "cntxt", cntxt);
   
   ap = new("ap", this);
   
endfunction : build_phase


task uvma_axis_drv_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   forever begin
      wait (cfg.enabled && cfg.is_active) begin
         case (cntxt.reset_state)
            UVMA_AXIS_RESET_STATE_PRE_RESET : drv_pre_reset (phase);
            UVMA_AXIS_RESET_STATE_IN_RESET  : drv_in_reset  (phase);
            UVMA_AXIS_RESET_STATE_POST_RESET: drv_post_reset(phase);
         endcase
      end
   end
   
endtask : run_phase


task uvma_axis_drv_c::drv_pre_reset(uvm_phase phase);
   
   case (cfg.mode)
      UVMA_AXIS_MODE_MASTER: drv_mstr_idle();
      UVMA_AXIS_MODE_SLAVE : @(cntxt.vif.active_slave_mp.drv_slv_cb);
      
      default: `uvm_fatal("AXIS_DRV", $sformatf("Invalid cfg.mode: %s", cfg.mode.name()))
   endcase
   
endtask : drv_pre_reset


task uvma_axis_drv_c::drv_in_reset(uvm_phase phase);
   
   case (cfg.mode)
      UVMA_AXIS_MODE_MASTER: drv_mstr_idle();
      UVMA_AXIS_MODE_SLAVE : @(cntxt.vif.active_slave_mp.drv_slv_cb);
      
      default: `uvm_fatal("AXIS_DRV", $sformatf("Invalid cfg.mode: %s", cfg.mode.name()))
   endcase
   
endtask : drv_in_reset


task uvma_axis_drv_c::drv_post_reset(uvm_phase phase);
   
   seq_item_port.get_next_item(req);
   
   case (cfg.mode)
      UVMA_AXIS_MODE_MASTER: drv_mstr_req(req);
      UVMA_AXIS_MODE_SLAVE : drv_slv_req (req);
      
      default: `uvm_fatal("AXIS_DRV", $sformatf("Invalid cfg.mode: %s", cfg.mode.name()))
   endcase
   
   ap.write(req);
   seq_item_port.item_done();
   
endtask : drv_post_reset


task uvma_axis_drv_c::drv_mstr_req(ref uvma_axis_cycle_seq_item_c req);
   
   `uvml_hrtbt()
   
   @(cntxt.vif.active_master_mp.drv_master_cb);
   
   if (req.tvalid) begin
      // Wait for tready
      if (cntxt.vif.active_master_mp.drv_master_cb.tready !== 1) begin
         while (cntxt.vif.active_master_mp.drv_master_cb.tready !== 1) begin
            @(cntxt.vif.active_master_mp.drv_master_cb);
         end
         // Wait one more cycle
         @(cntxt.vif.active_master_mp.drv_master_cb);
      end
   end
   
   // Drive bus
   cntxt.vif.active_master_mp.drv_master_cb.tvalid <= req.tvalid;
   cntxt.vif.active_master_mp.drv_master_cb.tstrb  <= req.tstrb ;
   cntxt.vif.active_master_mp.drv_master_cb.tkeep  <= req.tkeep ;
   cntxt.vif.active_master_mp.drv_master_cb.tlast  <= req.tlast ;
   cntxt.vif.active_master_mp.drv_master_cb.tid    <= req.tid   ;
   cntxt.vif.active_master_mp.drv_master_cb.tdest  <= req.tdest ;
   cntxt.vif.active_master_mp.drv_master_cb.tuser  <= req.tuser ;
   
   // Drive bus data
   
   for (int unsigned ii=0; ii<cfg.data_bus_width; ii++) begin
      cntxt.vif.active_master_mp.drv_master_cb.tdata[ii] <= req.tdata[ii];
   end
   
endtask : drv_mstr_req


task uvma_axis_drv_c::drv_slv_req(ref uvma_axis_cycle_seq_item_c req);
   
   @(cntxt.vif.active_slave_mp.drv_slave_cb);
   cntxt.vif.active_slave_mp.drv_slave_cb.tready <= req.tready;
   
endtask : drv_slv_req


task uvma_axis_drv_c::drv_mstr_idle();
   
   @(cntxt.vif.active_master_mp.drv_master_cb);
   cntxt.vif.active_master_mp.drv_master_cb.tvalid <= '0;
   
   case (cfg.drv_idle)
      UVMA_AXIS_DRV_IDLE_ZEROS : begin
         cntxt.vif.active_master_mp.drv_master_cb.tdata  <= '0;
         cntxt.vif.active_master_mp.drv_master_cb.tstrb  <= '0;
         cntxt.vif.active_master_mp.drv_master_cb.tkeep  <= '0;
         cntxt.vif.active_master_mp.drv_master_cb.tlast  <= '0;
         cntxt.vif.active_master_mp.drv_master_cb.tid    <= '0;
         cntxt.vif.active_master_mp.drv_master_cb.tdest  <= '0;
         cntxt.vif.active_master_mp.drv_master_cb.tuser  <= '0;
      end
      
      UVMA_AXIS_DRV_IDLE_RANDOM : begin
         cntxt.vif.active_master_mp.drv_master_cb.tdata  <= {(cfg.data_bus_width/4)*{$urandom()}};
         cntxt.vif.active_master_mp.drv_master_cb.tstrb  <= $urandom();
         cntxt.vif.active_master_mp.drv_master_cb.tkeep  <= $urandom();
         cntxt.vif.active_master_mp.drv_master_cb.tlast  <= $urandom();
         cntxt.vif.active_master_mp.drv_master_cb.tid    <= $urandom();
         cntxt.vif.active_master_mp.drv_master_cb.tdest  <= $urandom();
         cntxt.vif.active_master_mp.drv_master_cb.tuser  <= $urandom();
      end
      
      UVMA_AXIS_DRV_IDLE_X: begin
         cntxt.vif.active_master_mp.drv_master_cb.tdata <= 'X;
         cntxt.vif.active_master_mp.drv_master_cb.tstrb <= 'X;
         cntxt.vif.active_master_mp.drv_master_cb.tkeep <= 'X;
         cntxt.vif.active_master_mp.drv_master_cb.tlast <= 'X;
         cntxt.vif.active_master_mp.drv_master_cb.tid   <= 'X;
         cntxt.vif.active_master_mp.drv_master_cb.tdest <= 'X;
         cntxt.vif.active_master_mp.drv_master_cb.tuser <= 'X;
      end
      
      UVMA_AXIS_DRV_IDLE_Z: begin
         cntxt.vif.active_master_mp.drv_master_cb.tdata <= 'Z;
         cntxt.vif.active_master_mp.drv_master_cb.tstrb <= 'Z;
         cntxt.vif.active_master_mp.drv_master_cb.tkeep <= 'Z;
         cntxt.vif.active_master_mp.drv_master_cb.tlast <= 'Z;
         cntxt.vif.active_master_mp.drv_master_cb.tid   <= 'Z;
         cntxt.vif.active_master_mp.drv_master_cb.tdest <= 'Z;
         cntxt.vif.active_master_mp.drv_master_cb.tuser <= 'Z;
      end
      
      default: `uvm_fatal("AXIS_DRV", $sformatf("Invalid cfg.drv_idle: %s", cfg.drv_idle.name()))
   endcase
   
endtask : drv_mstr_idle


`endif // __UVMA_AXIS_DRV_SV__
