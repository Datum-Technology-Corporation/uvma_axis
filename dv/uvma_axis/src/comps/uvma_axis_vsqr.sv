// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_VSQR_SV__
`define __UVMA_AXIS_VSQR_SV__


/**
 * Component running AMBA Advanced Extensible Interface Stream sequences extending uvma_axis_seq_base_c.
 */
class uvma_axis_vsqr_c extends uvml_vsqr_c #(
   .REQ(uvma_axis_seq_item_c),
   .RSP(uvma_axis_seq_item_c)
);
   
   // Objects
   uvma_axis_cfg_c    cfg  ; ///< 
   uvma_axis_cntxt_c  cntxt; ///< 
   
   // Components
   uvma_axis_mstr_sqr_c  mstr_sequencer; ///< 
   uvma_axis_slv_sqr_c   slv_sequencer ; ///< 
   
   // TLM
   uvm_seq_item_pull_port #(uvm_sequence_item       )  upstream_sqr_port  ; ///< TODO Describe uvma_axis_vsqr_c::upstream_sqr_port
   uvm_analysis_port      #(uvma_axis_mon_trn_c     )  mon_trn_ap         ; ///< TODO Describe uvma_axis_vsqr_c::mon_trn_ap
   uvm_analysis_port      #(uvma_axis_seq_item_c    )  seq_item_ap        ; ///< TODO Describe uvma_axis_vsqr_c::seq_item_ap
   uvm_tlm_analysis_fifo  #(uvma_axis_mstr_mon_trn_c)  mstr_mon_trn_fifo  ; ///< TODO Describe uvma_axis_vsqr_c::mstr_mon_trn_fifo
   uvm_tlm_analysis_fifo  #(uvma_axis_slv_mon_trn_c )  slv_mon_trn_fifo   ; ///< TODO Describe uvma_axis_vsqr_c::slv_mon_trn_fifo
   uvm_analysis_export    #(uvma_axis_mstr_mon_trn_c)  mstr_mon_trn_export; ///< TODO Describe uvma_axis_vsqr_c::mstr_mon_trn_export
   uvm_analysis_export    #(uvma_axis_slv_mon_trn_c )  slv_mon_trn_export ; ///< TODO Describe uvma_axis_vsqr_c::slv_mon_trn_export
   
   
   `uvm_component_utils_begin(uvma_axis_vsqr_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_vsqr", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_axis_vsqr_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
endclass : uvma_axis_vsqr_c


function uvma_axis_vsqr_c::new(string name="uvma_axis_vsqr", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_axis_vsqr_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_axis_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_axis_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   mstr_sequencer = uvma_axis_mstr_sqr_c::type_id::create("mstr_sequencer", this);
   slv_sequencer  = uvma_axis_slv_sqr_c ::type_id::create("slv_sequencer" , this);
   
   upstream_sqr_port   = new("upstream_sqr_port"  , this);
   mon_trn_ap          = new("mon_trn_ap"         , this);
   seq_item_ap         = new("seq_item_ap"        , this);
   mstr_mon_trn_fifo   = new("mstr_mon_trn_fifo"  , this);
   slv_mon_trn_fifo    = new("slv_mon_trn_fifo"   , this);
   mstr_mon_trn_export = new("mstr_mon_trn_export", this);
   slv_mon_trn_export  = new("slv_mon_trn_export" , this);
   
endfunction : build_phase


function void uvma_axis_vsqr_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect exports to FIFOs
   mstr_mon_trn_export.connect(mstr_mon_trn_fifo.analysis_export);
   slv_mon_trn_export .connect(slv_mon_trn_fifo .analysis_export);
   
endfunction : connect_phase


`endif // __UVMA_AXIS_VSQR_SV__
