// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_DRV_SV__
`define __UVMA_AXIS_DRV_SV__


/**
 * Component driving a AMBA Advanced Extensible Interface Stream virtual interface (uvma_axis_if).
 */
class uvma_axis_drv_c extends uvm_component;
   
   // Objects
   uvma_axis_cfg_c    cfg  ; ///< 
   uvma_axis_cntxt_c  cntxt; ///< 
   
   // Components
   uvma_axis_mstr_drv_c  mstr_driver; ///< TODO Describe uvma_axis_drv_c::mstr_driver
   uvma_axis_slv_drv_c   slv_driver ; ///< TODO Describe uvma_axis_drv_c::slv_driver
   
   // TLM
   uvm_analysis_port#(uvma_axis_mstr_seq_item_c)  mstr_ap; ///< 
   uvm_analysis_port#(uvma_axis_slv_seq_item_c )  slv_ap ; ///< 
   
   
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
    * TODO Describe uvma_axis_drv_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
endclass : uvma_axis_drv_c


function uvma_axis_drv_c::new(string name="uvma_axis_drv", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_axis_drv_c::build_phase(uvm_phase phase);
   
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
   
   // Create components
   mstr_driver = uvma_axis_mstr_drv_c::type_id::create("mstr_driver", this);
   slv_driver  = uvma_axis_slv_drv_c ::type_id::create("slv_driver" , this);
   
   // Create TLM Components
   mstr_ap = new("mstr_ap", this);
   slv_ap  = new("slv_ap" , this);
   
endfunction : build_phase


function void uvma_axis_drv_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   mstr_ap = mstr_driver.ap;
   slv_ap  = slv_driver .ap;
   
endfunction : connect_phase


`endif // __UVMA_AXIS_DRV_SV__
