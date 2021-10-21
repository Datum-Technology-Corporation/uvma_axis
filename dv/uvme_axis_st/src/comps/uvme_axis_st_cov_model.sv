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
   
   
   covergroup cfg_cg;
      /*abc_cpt : coverpoint cfg.abc;
      xyz_cpt : coverpoint cfg.xyz;*/
   endgroup : cfg_cg
   
   covergroup cntxt_cg;
      /*abc_cpt : coverpoint cntxt.abc;
      xyz_cpt : coverpoint cntxt.xyz;*/
   endgroup : cntxt_cg
   
   covergroup mon_trn_cg;
      /*address : coverpoint mon_trn.address {
         bins low   = {16'h0000_0000, 16'h4FFF_FFFF};
         bins med   = {16'h5000_0000, 16'h9FFF_FFFF};
         bins high  = {16'hA000_0000, 16'hFFFF_FFFF};
      }*/
   endgroup : mon_trn_cg
   
   covergroup seq_item_cg;
      /*address : coverpoint seq_item.address {
         bins low   = {16'h0000_0000, 16'h5FFF_FFFF};
         bins med   = {16'h6000_0000, 16'hAFFF_FFFF};
         bins high  = {16'hB000_0000, 16'hFFFF_FFFF};
      }*/
   endgroup : seq_item_cg
   
   covergroup mstr_mon_trn_cg;
      /*address : coverpoint mstr_mon_trn.address {
         bins low   = {16'h0000_0000, 16'h4FFF_FFFF};
         bins med   = {16'h5000_0000, 16'h9FFF_FFFF};
         bins high  = {16'hA000_0000, 16'hFFFF_FFFF};
      }*/
   endgroup : mstr_mon_trn_cg
   
   covergroup mstr_seq_item_cg;
      /*address : coverpoint mstr_seq_item.address {
         bins low   = {16'h0000_0000, 16'h5FFF_FFFF};
         bins med   = {16'h6000_0000, 16'hAFFF_FFFF};
         bins high  = {16'hB000_0000, 16'hFFFF_FFFF};
      }*/
   endgroup : mstr_seq_item_cg
   
   covergroup slv_mon_trn_cg;
      /*address : coverpoint slv_mon_trn.address {
         bins low   = {16'h0000_0000, 16'h4FFF_FFFF};
         bins med   = {16'h5000_0000, 16'h9FFF_FFFF};
         bins high  = {16'hA000_0000, 16'hFFFF_FFFF};
      }*/
   endgroup : slv_mon_trn_cg
   
   covergroup slv_seq_item_cg;
      /*address : coverpoint slv_seq_item.address {
         bins low   = {16'h0000_0000, 16'h5FFF_FFFF};
         bins med   = {16'h6000_0000, 16'hAFFF_FFFF};
         bins high  = {16'hB000_0000, 16'hFFFF_FFFF};
      }*/
   endgroup : slv_seq_item_cg
   
   
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
