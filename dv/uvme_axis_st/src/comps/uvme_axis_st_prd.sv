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


`ifndef __UVME_AXIS_ST_PRD_SV__
`define __UVME_AXIS_ST_PRD_SV__


/**
 * Component implementing transaction-based software model of AXI-Stream Agent Self-Testing DUT.
 */
class uvme_axis_st_prd_c extends uvm_component;
   
   // Objects
   uvme_axis_st_cfg_c    cfg  ; ///< 
   uvme_axis_st_cntxt_c  cntxt; ///< 
   
   // TLM
   uvm_analysis_export  #(uvma_axis_mon_trn_c )  e2e_in_export ; ///< 
   uvm_analysis_export  #(uvma_axis_seq_item_c)  mstr_in_export; ///< 
   uvm_tlm_analysis_fifo#(uvma_axis_mon_trn_c )  e2e_in_fifo   ; ///< 
   uvm_tlm_analysis_fifo#(uvma_axis_seq_item_c)  mstr_in_fifo  ; ///< 
   uvm_analysis_port    #(uvma_axis_mon_trn_c )  e2e_out_ap    ; ///< 
   uvm_analysis_port    #(uvma_axis_mon_trn_c )  mstr_out_ap   ; ///< 
   
   
   `uvm_component_utils_begin(uvme_axis_st_prd_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_axis_st_prd", uvm_component parent=null);
   
   /**
    * TODO Describe uvme_axis_st_prd_c::build_phase()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_axis_st_prd_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_axis_st_prd_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
endclass : uvme_axis_st_prd_c


function uvme_axis_st_prd_c::new(string name="uvme_axis_st_prd", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_axis_st_prd_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_axis_st_cfg_c)::get(this, "", "cfg", cfg));
   if (cfg == null) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_axis_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (cntxt == null) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // Build TLM objects
   e2e_in_export   = new("e2e_in_export" , this);
   mstr_in_export  = new("mstr_in_export", this);
   e2e_in_fifo     = new("e2e_in_fifo"   , this);
   mstr_in_fifo    = new("mstr_in_fifo"  , this);
   e2e_out_ap      = new("e2e_out_ap"    , this);
   mstr_out_ap     = new("mstr_out_ap"   , this);
   
endfunction : build_phase


function void uvme_axis_st_prd_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   e2e_in_export .connect(e2e_in_fifo .analysis_export);
   mstr_in_export.connect(mstr_in_fifo.analysis_export);
   
endfunction: connect_phase


task uvme_axis_st_prd_c::run_phase(uvm_phase phase);
   
   uvma_axis_seq_item_c mstr_in_trn;
   uvma_axis_mon_trn_c  mstr_out_trn, e2e_in_trn, e2e_out_trn;
   
   super.run_phase(phase);
   
   fork
      begin : e2e
         forever begin
            // Get next transaction and copy it
            e2e_in_fifo.get(e2e_in_trn);
            e2e_out_trn = uvma_axis_mon_trn_c::type_id::create("e2e_out_trn");
            e2e_out_trn.copy(e2e_in_trn);
            e2e_out_trn.cfg = e2e_in_trn.cfg;
            e2e_out_trn.set_may_drop(cntxt.slv_cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
            
            // Send transaction to analysis port
            e2e_out_ap.write(e2e_out_trn);
         end
      end
      
      begin : mstr
         forever begin
            // Get next transaction and copy it
            mstr_in_fifo.get(mstr_in_trn);
            mstr_out_trn = uvma_axis_mon_trn_c::type_id::create("mstr_out_trn");
            mstr_out_trn.set_initiator(mstr_in_trn.get_initiator());
            mstr_out_trn.cfg   = mstr_in_trn.cfg  ;
            mstr_out_trn.size  = mstr_in_trn.size ;
            mstr_out_trn.tid   = mstr_in_trn.tid  ;
            mstr_out_trn.tdest = mstr_in_trn.tdest;
            mstr_out_trn.tuser = mstr_in_trn.tuser;
            mstr_out_trn.set_may_drop(cntxt.mstr_cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
            foreach (mstr_in_trn.data[ii]) begin
               mstr_out_trn.data.push_back(mstr_in_trn.data[ii]);
            end
            
            // Send transaction to analysis port
            mstr_out_ap.write(mstr_out_trn);
         end
      end
   join_none
   
endtask: run_phase


`endif // __UVME_AXIS_ST_PRD_SV__
