// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_MSTR_DRV_SV__
`define __UVMA_AXIS_MSTR_DRV_SV__


/**
 * TODO Describe uvma_axis_mstr_drv_c
 */
class uvma_axis_mstr_drv_c extends uvml_drv_c #(
   .REQ(uvma_axis_mstr_seq_item_c),
   .RSP(uvma_axis_mstr_seq_item_c)
);;
   
   virtual uvma_axis_if.drv_mstr_mp  mp; ///< Handle to virtual interface modport
   
   // Objects
   uvma_axis_cfg_c    cfg  ; ///< 
   uvma_axis_cntxt_c  cntxt; ///< 
   
   // TLM
   uvm_analysis_port#(uvma_axis_mstr_seq_item_c)  ap; ///< 
   
   
   `uvm_component_utils_begin(uvma_axis_mstr_drv_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_mstr_drv", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_axis_mstr_drv_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_axis_mstr_drv_c::process_req()
    */
   extern virtual function void process_req(ref uvma_axis_mstr_seq_item_c req);
   
   /**
    * TODO Describe uvma_axis_mstr_drv_c::drv_req()
    */
   extern virtual task drv_req(ref uvma_axis_mstr_seq_item_c req);
   
   /**
    * TODO Describe uvma_axis_mstr_drv_c::sample_post_clk()
    */
   extern virtual task sample_post_clk(ref uvma_axis_mstr_seq_item_c req);
   
endclass : uvma_axis_mstr_drv_c


function uvma_axis_mstr_drv_c::new(string name="uvma_axis_mstr_drv", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_axis_mstr_drv_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_axis_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   uvm_config_db#(uvma_axis_cfg_c)::set(this, "*", "cfg", cfg);
   
   void'(uvm_config_db#(uvma_axis_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   uvm_config_db#(uvma_axis_cntxt_c)::set(this, "*", "cntxt", cntxt);
   
   ap = new("ap", this);
   mp = cntxt.vif.drv_mstr_mp;
   
endfunction : build_phase


task uvma_axis_mstr_drv_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   if (cfg.enabled && cfg.is_active && (cfg.drv_mode == UVMA_AXIS_DRV_MODE_MSTR)) begin
      forever begin
         seq_item_port.get_next_item(req);
         process_req                (req);
         drv_req                    (req);
         ap.write                   (req);
         
         @(mp.drv_mstr_cb);
         sample_post_clk(req);
         seq_item_port.item_done();
      end
   end
   
endtask : run_phase


function void uvma_axis_mstr_drv_c::process_req(ref uvma_axis_mstr_seq_item_c req);
   
   req.cfg = cfg;
   `uvm_info("AXIS_MSTR_DRV", $sformatf("Got new req from the sequencer:\n%s", req.sprint()), UVM_DEBUG)
   
endfunction: process_req


task uvma_axis_mstr_drv_c::drv_req(ref uvma_axis_mstr_seq_item_c req);
   
   mp.drv_mstr_cb.tvalid <= req.tvalid;
   mp.drv_mstr_cb.tlast  <= req.tlast ;
   
   for (int unsigned ii=0; ii<cfg.tdata_width; ii++) begin
      mp.drv_mstr_cb.tdata[ii] <= req.tdata[ii];
   end
   for (int unsigned ii=0; ii<cfg.tdata_width; ii++) begin
      mp.drv_mstr_cb.tstrb[ii] <= req.tstrb[ii];
   end
   for (int unsigned ii=0; ii<cfg.tdata_width; ii++) begin
      mp.drv_mstr_cb.tkeep[ii] <= req.tkeep[ii];
   end
   for (int unsigned ii=0; ii<cfg.tid_width; ii++) begin
      mp.drv_mstr_cb.tid[ii] <= req.tid[ii];
   end
   for (int unsigned ii=0; ii<cfg.tdest_width; ii++) begin
      mp.drv_mstr_cb.tdest[ii] <= req.tdest[ii];
   end
   for (int unsigned ii=0; ii<cfg.tuser_width; ii++) begin
      mp.drv_mstr_cb.tuser[ii] <= req.tuser[ii];
   end
   
endtask : drv_req


task uvma_axis_mstr_drv_c::sample_post_clk(ref uvma_axis_mstr_seq_item_c req);
   
   req.tready = mp.drv_mstr_cb.tready;
   
endtask : sample_post_clk


`endif // __UVMA_AXIS_MSTR_DRV_SV__
