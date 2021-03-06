// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_AGENT_SV__
`define __UVMA_AXIS_AGENT_SV__


/**
 * Top-level component that encapsulates, builds and connects all others.
 * Capable of driving/monitoring AMBA Advanced Extensible Interface Stream interface.
 */
class uvma_axis_agent_c extends uvml_agent_c;
   
   // Objects
   uvma_axis_cfg_c    cfg  ; ///< 
   uvma_axis_cntxt_c  cntxt; ///< 
   
   // Components
   uvma_axis_drv_c        driver    ; ///< 
   uvma_axis_mon_c        monitor   ; ///< 
   uvma_axis_vsqr_c       vsequencer; ///< 
   uvma_axis_logger_c     logger    ; ///< 
   uvma_axis_cov_model_c  cov_model ; ///< 
   
   // TLM
   uvm_analysis_port#(uvma_axis_seq_item_c     )  seq_item_ap; //< 
   uvm_analysis_port#(uvma_axis_mon_trn_c      )  mon_trn_ap ; //< 
   uvm_analysis_port#(uvma_axis_mstr_mon_trn_c )  mon_mstr_ap; //< 
   uvm_analysis_port#(uvma_axis_slv_mon_trn_c  )  mon_slv_ap ; //< 
   uvm_analysis_port#(uvma_axis_mstr_seq_item_c)  drv_mstr_ap; //< 
   uvm_analysis_port#(uvma_axis_slv_seq_item_c )  drv_slv_ap ; //< 
   
   
   `uvm_component_utils_begin(uvma_axis_agent_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_agent", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null
    * 2. Builds all components
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * 1. Links agent's analysis ports to sub-components'
    * 2. Connects coverage models and loggers
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_axis_agent_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * Uses uvm_config_db to retrieve cfg and hand out to sub-components.
    */
   extern function void get_and_set_cfg();
   
   /**
    * Uses uvm_config_db to retrieve cntxt and hand out to sub-components.
    */
   extern function void get_and_set_cntxt();
   
   /**
    * Uses uvm_config_db to retrieve the Virtual Interface (vif) associated with this
    * agent.
    */
   extern function void retrieve_vif();
   
   /**
    * Creates sub-components.
    */
   extern function void create_components();
   
   /**
    * TODO Describe uvma_axis_agent_c::create_analysis_ports()
    */
    extern function void create_analysis_ports();
   
   /**
    * Connects sequencer and driver's TLM ports.
    */
   extern function void connect_sequencer();
   
   /**
    * Connects agent's TLM ports to driver's and monitor's.
    */
   extern function void connect_analysis_ports();
   
   /**
    * Connects coverage model to monitor and driver's analysis ports.
    */
   extern function void connect_cov_model();
   
   /**
    * Connects transaction loggers to monitor and driver's analysis ports.
    */
   extern function void connect_trn_loggers();
   
   /**
    * TODO Describe uvma_axis_agent_c::start_mon_vseq()
    */
   extern task start_mon_vseq();
   
   /**
    * TODO Describe uvma_axis_agent_c::start_idle_vseq()
    */
   extern task start_idle_vseq();
   
   /**
    * TODO Describe uvma_axis_agent_c::start_mstr_drv_vseq()
    */
   extern task start_mstr_drv_vseq();
   
   /**
    * TODO Describe uvma_axis_agent_c::start_slv_drv_vseq()
    */
   extern task start_slv_drv_vseq();
   
endclass : uvma_axis_agent_c


function uvma_axis_agent_c::new(string name="uvma_axis_agent", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_axis_agent_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   get_and_set_cfg      ();
   get_and_set_cntxt    ();
   retrieve_vif         ();
   create_components    ();
   create_analysis_ports();
   
endfunction : build_phase


function void uvma_axis_agent_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   connect_sequencer();
   connect_analysis_ports();
   
   if (cfg.cov_model_enabled) begin
      connect_cov_model();
   end
   if (cfg.trn_log_enabled) begin
      connect_trn_loggers();
   end
   
endfunction: connect_phase


task uvma_axis_agent_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   if (cfg.enabled) begin
      start_mon_vseq();
      
      if (cfg.is_active) begin
         start_idle_vseq();
         
         case (cfg.drv_mode)
            UVMA_AXIS_DRV_MODE_MSTR: start_mstr_drv_vseq();
            UVMA_AXIS_DRV_MODE_SLV : start_slv_drv_vseq ();
            
            default: begin
               `uvm_fatal("AXIS_AGENT", $sformatf("Invalid cfg.drv_mode: %s", cfg.drv_mode.name()))
            end
         endcase
      end
   end
   
endtask : run_phase


function void uvma_axis_agent_c::get_and_set_cfg();
   
   void'(uvm_config_db#(uvma_axis_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   else begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
      uvm_config_db#(uvma_axis_cfg_c)::set(this, "*", "cfg", cfg);
   end
   
endfunction : get_and_set_cfg


function void uvma_axis_agent_c::get_and_set_cntxt();
   
   void'(uvm_config_db#(uvma_axis_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_info("CNTXT", "Context handle is null; creating.", UVM_DEBUG)
      cntxt = uvma_axis_cntxt_c::type_id::create("cntxt");
   end
   uvm_config_db#(uvma_axis_cntxt_c)::set(this, "*", "cntxt", cntxt);
   
endfunction : get_and_set_cntxt


function void uvma_axis_agent_c::retrieve_vif();
   
   if (!uvm_config_db#(virtual uvma_axis_if)::get(this, "", "vif", cntxt.vif)) begin
      `uvm_fatal("VIF", $sformatf("Could not find vif handle of type %s in uvm_config_db", $typename(cntxt.vif)))
   end
   else begin
      `uvm_info("VIF", $sformatf("Found vif handle of type %s in uvm_config_db", $typename(cntxt.vif)), UVM_DEBUG)
   end
   
endfunction : retrieve_vif


function void uvma_axis_agent_c::create_components();
   
   monitor    = uvma_axis_mon_c      ::type_id::create("monitor"   , this);
   vsequencer = uvma_axis_vsqr_c     ::type_id::create("vsequencer", this);
   driver     = uvma_axis_drv_c      ::type_id::create("driver"    , this);
   cov_model  = uvma_axis_cov_model_c::type_id::create("cov_model" , this);
   logger     = uvma_axis_logger_c   ::type_id::create("logger"    , this);
   
endfunction : create_components


function void uvma_axis_agent_c::create_analysis_ports();
   
   seq_item_ap  = new("seq_item_ap", this);
   mon_trn_ap   = new("mon_trn_ap" , this);
   mon_mstr_ap  = new("mon_mstr_ap", this);
   mon_slv_ap   = new("mon_slv_ap" , this);
   drv_mstr_ap  = new("drv_mstr_ap", this);
   drv_slv_ap   = new("drv_slv_ap" , this);
   
endfunction : create_analysis_ports


function void uvma_axis_agent_c::connect_sequencer();
   
   vsequencer               .set_arbitration(cfg.sqr_arb_mode);
   vsequencer.mstr_sequencer.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
   vsequencer.slv_sequencer .set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
   
   if (!cfg.bypass_mode) begin
      driver.mstr_driver.seq_item_port.connect(vsequencer.mstr_sequencer.seq_item_export);
      driver.slv_driver .seq_item_port.connect(vsequencer.slv_sequencer .seq_item_export);
      monitor.mstr_ap.connect(vsequencer.mstr_mon_trn_export);
      monitor.mstr_ap.connect(vsequencer.mstr_mon_trn_export);
      monitor.slv_ap .connect(vsequencer.slv_mon_trn_export );
      monitor.slv_ap .connect(vsequencer.slv_mon_trn_export );
   end
   
endfunction : connect_sequencer


function void uvma_axis_agent_c::connect_analysis_ports();
   
   mon_trn_ap  = vsequencer.mon_trn_ap ;
   seq_item_ap = vsequencer.seq_item_ap;
   drv_mstr_ap = driver.mstr_driver.ap ;
   drv_slv_ap  = driver.slv_driver .ap ;
   mon_mstr_ap = monitor.mstr_ap       ;
   mon_slv_ap  = monitor.slv_ap        ;
   
endfunction : connect_analysis_ports


function void uvma_axis_agent_c::connect_cov_model();
   
   seq_item_ap.connect(cov_model.seq_item_fifo     .analysis_export);
   mon_trn_ap .connect(cov_model.mon_trn_fifo      .analysis_export);
   drv_mstr_ap.connect(cov_model.mstr_seq_item_fifo.analysis_export);
   drv_slv_ap .connect(cov_model.slv_seq_item_fifo .analysis_export);
   mon_mstr_ap.connect(cov_model.mstr_mon_trn_fifo .analysis_export);
   mon_slv_ap .connect(cov_model.slv_mon_trn_fifo  .analysis_export);
   
endfunction : connect_cov_model


function void uvma_axis_agent_c::connect_trn_loggers();
   
   seq_item_ap.connect(logger.seq_item_logger_export     );
   mon_trn_ap .connect(logger.mon_trn_logger_export      );
   drv_mstr_ap.connect(logger.mstr_seq_item_logger_export);
   drv_slv_ap .connect(logger.slv_seq_item_logger_export );
   mon_mstr_ap.connect(logger.mstr_mon_trn_logger_export );
   mon_slv_ap .connect(logger.slv_mon_trn_logger_export  );
   
endfunction : connect_trn_loggers


task uvma_axis_agent_c::start_mon_vseq();
   
   uvm_coreservice_t cs = uvm_coreservice_t::get();
   uvm_factory       f  = cs.get_factory();
   uvm_object        temp_obj;
   
   temp_obj = f.create_object_by_type(cfg.mon_vseq_type, get_full_name(), cfg.mon_vseq_type.get_type_name());
   if (!$cast(cntxt.mon_vseq, temp_obj)) begin
      `uvm_fatal("AXIS_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.mon_vseq' (%s)", $typename(temp_obj), $typename(cntxt.mon_vseq)))
   end
   
   if (!cntxt.mon_vseq.randomize()) begin
      `uvm_fatal("AXIS_AGENT", "Failed to randomize cntxt.mon_vseq")
   end
   
   fork
      cntxt.mon_vseq.start(vsequencer);
   join_none
   
endtask : start_mon_vseq


task uvma_axis_agent_c::start_idle_vseq();
   
   uvm_coreservice_t cs = uvm_coreservice_t::get();
   uvm_factory       f  = cs.get_factory();
   uvm_object        temp_obj;
   
   temp_obj = f.create_object_by_type(cfg.idle_vseq_type, get_full_name(), cfg.idle_vseq_type.get_type_name());
   if (!$cast(cntxt.idle_vseq, temp_obj)) begin
      `uvm_fatal("AXIS_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.idle_vseq' (%s)", $typename(temp_obj), $typename(cntxt.idle_vseq)))
   end
   
   if (!cntxt.idle_vseq.randomize()) begin
      `uvm_fatal("AXIS_AGENT", "Failed to randomize cntxt.idle_vseq")
   end
   
   fork
      cntxt.idle_vseq.start(vsequencer);
   join_none
   
endtask : start_idle_vseq


task uvma_axis_agent_c::start_mstr_drv_vseq();
   
   uvm_coreservice_t cs = uvm_coreservice_t::get();
   uvm_factory       f  = cs.get_factory();
   uvm_object        temp_obj;
   
   temp_obj = f.create_object_by_type(cfg.mstr_drv_vseq_type, get_full_name(), cfg.mstr_drv_vseq_type.get_type_name());
   if (!$cast(cntxt.mstr_drv_vseq, temp_obj)) begin
      `uvm_fatal("AXIS_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.mstr_drv_vseq' (%s)", $typename(temp_obj), $typename(cntxt.mstr_drv_vseq)))
   end
   
   if (!cntxt.mstr_drv_vseq.randomize()) begin
      `uvm_fatal("AXIS_AGENT", "Failed to randomize cntxt.mstr_drv_vseq")
   end
   
   fork
      cntxt.mstr_drv_vseq.start(vsequencer);
   join_none
   
endtask : start_mstr_drv_vseq


task uvma_axis_agent_c::start_slv_drv_vseq();
   
   uvm_coreservice_t cs = uvm_coreservice_t::get();
   uvm_factory       f  = cs.get_factory();
   uvm_object        temp_obj;
   
   temp_obj = f.create_object_by_type(cfg.slv_drv_vseq_type, get_full_name(), cfg.slv_drv_vseq_type.get_type_name());
   if (!$cast(cntxt.slv_drv_vseq, temp_obj)) begin
      `uvm_fatal("AXIS_AGENT", $sformatf("Could not cast 'temp_obj' (%s) to 'cntxt.slv_drv_vseq' (%s)", $typename(temp_obj), $typename(cntxt.slv_drv_vseq)))
   end
   
   if (!cntxt.slv_drv_vseq.randomize()) begin
      `uvm_fatal("AXIS_AGENT", "Failed to randomize cntxt.slv_drv_vseq")
   end
   
   fork
      cntxt.slv_drv_vseq.start(vsequencer);
   join_none
   
endtask : start_slv_drv_vseq


`endif // __UVMA_AXIS_AGENT_SV__
