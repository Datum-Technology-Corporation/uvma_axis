// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_AXIS_ST_COV_MODEL_SV__
`define __UVME_AXIS_ST_COV_MODEL_SV__


/**
 * TODO Describe uvme_axis_st_cov_model_c
 */
class uvme_axis_st_cov_model_c extends uvma_axis_cov_model_c;
   
   `uvm_component_utils_begin(uvme_axis_st_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   /*
   covergroup cfg_cg;
   endgroup : cfg_cg
   
   covergroup cntxt_cg;
   endgroup : cntxt_cg
   
   covergroup mon_trn_cg;
   endgroup : mon_trn_cg
   
   covergroup seq_item_cg;
   endgroup : seq_item_cg
   
   covergroup mstr_mon_trn_cg;
   endgroup : mstr_mon_trn_cg
   
   covergroup mstr_seq_item_cg;
   endgroup : mstr_seq_item_cg
   
   covergroup slv_mon_trn_cg;
   endgroup : slv_mon_trn_cg
   
   covergroup slv_seq_item_cg;
   endgroup : slv_seq_item_cg*/
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_axis_st_cov_model", uvm_component parent=null);
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_cfg()
    */
   extern virtual function void sample_cfg();
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_cntxt()
    */
   extern virtual function void sample_cntxt();
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_mon_trn()
    */
   extern virtual function void sample_mon_trn();
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_seq_item()
    */
   extern virtual function void sample_seq_item();
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_mstr_mon_trn()
    */
   extern virtual function void sample_mstr_mon_trn();
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_mstr_seq_item()
    */
   extern virtual function void sample_mstr_seq_item();
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_slv_mon_trn()
    */
   extern virtual function void sample_slv_mon_trn();
   
   /**
    * TODO Describe uvme_axis_st_cov_model_c::sample_slv_seq_item()
    */
   extern virtual function void sample_slv_seq_item();
   
endclass : uvme_axis_st_cov_model_c


function uvme_axis_st_cov_model_c::new(string name="uvme_axis_st_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_axis_st_cov_model_c::sample_cfg();
   
   // TODO Implement uvme_axis_st_cov_model_c::sample_cfg();
   
endfunction : sample_cfg


function void uvme_axis_st_cov_model_c::sample_cntxt();
   
   // TODO Implement uvme_axis_st_cov_model_c::sample_cntxt();
   
endfunction : sample_cntxt


function void uvme_axis_st_cov_model_c::sample_mon_trn();
   
   // TODO Implement uvme_axis_st_cov_model_c::sample_mon_trn();
   
endfunction : sample_mon_trn


function void uvme_axis_st_cov_model_c::sample_seq_item();
   
   // TODO Implement uvme_axis_st_cov_model_c::sample_seq_item();
   
endfunction : sample_seq_item


function void uvme_axis_st_cov_model_c::sample_mstr_mon_trn();
   
   // TODO Implement uvme_axis_st_cov_model_c::sample_mstr_mon_trn();
   
endfunction : sample_mstr_mon_trn


function void uvme_axis_st_cov_model_c::sample_mstr_seq_item();
   
   // TODO Implement uvme_axis_st_cov_model_c::sample_mstr_seq_item();
   
endfunction : sample_mstr_seq_item


function void uvme_axis_st_cov_model_c::sample_slv_mon_trn();
   
   // TODO Implement uvme_axis_st_cov_model_c::sample_slv_mon_trn();
   
endfunction : sample_slv_mon_trn


function void uvme_axis_st_cov_model_c::sample_slv_seq_item();
   
   // TODO Implement uvme_axis_st_cov_model_c::sample_slv_seq_item();
   
endfunction : sample_slv_seq_item


`endif // __UVME_AXIS_ST_COV_MODEL_SV__
