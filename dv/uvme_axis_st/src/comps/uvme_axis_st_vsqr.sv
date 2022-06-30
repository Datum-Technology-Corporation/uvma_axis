// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_AXIS_ST_VSQR_SV__
`define __UVME_AXIS_ST_VSQR_SV__


/**
 * Component on which all AMBA Advanced Extensible Interface Stream VIP Self-Test virtual sequences are run.
 */
class uvme_axis_st_vsqr_c extends uvml_vsqr_c #(
   .REQ(uvm_sequence_item),
   .RSP(uvm_sequence_item)
);
   
   // Objects
   uvme_axis_st_cfg_c    cfg;
   uvme_axis_st_cntxt_c  cntxt;
   
   // Sequencer handles
   uvma_axis_vsqr_c  mstr_vsequencer;
   uvma_axis_vsqr_c  slv_vsequencer ;
   
   
   `uvm_component_utils_begin(uvme_axis_st_vsqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_axis_st_sqr", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
endclass : uvme_axis_st_vsqr_c


function uvme_axis_st_vsqr_c::new(string name="uvme_axis_st_sqr", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_axis_st_vsqr_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_axis_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_axis_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
endfunction : build_phase


`endif // __UVME_AXIS_ST_VSQR_SV__
