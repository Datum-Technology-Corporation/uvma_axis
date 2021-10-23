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


`ifndef __UVMA_AXIS_BASE_VSEQ_SV__
`define __UVMA_AXIS_BASE_VSEQ_SV__


/**
 * Abstract object from which all other AMBA Advanced Extensible Interface Stream agent vsequences must extend.
 * Subclasses must be run on AMBA Advanced Extensible Interface Stream vsequencer (uvma_axis_sqr_c) instance.
 */
class uvma_axis_base_vseq_c extends uvml_vseq_c #(
   .REQ(uvma_axis_seq_item_c),
   .RSP(uvma_axis_seq_item_c)
);
   
   // Agent handles
   uvma_axis_cfg_c    cfg  ; ///< 
   uvma_axis_cntxt_c  cntxt; ///< 
   
   
   `uvm_object_utils(uvma_axis_base_vseq_c)
   `uvm_declare_p_sequencer(uvma_axis_vsqr_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_base_vseq");
   
   /**
    * Retrieve cfg and cntxt handles from p_vsequencer.
    */
   //extern virtual task pre_start();
   //
   ///**
   // * TODO Describe uvma_axis_base_vseq_c::upstream_get_next_item()
   // */
   //extern task upstream_get_next_item(ref uvm_sequence_item req);
   //
   ///**
   // * TODO Describe uvma_axis_base_vseq_c::upstream_item_done()
   // */
   //extern task upstream_item_done(ref uvm_sequence_item req);
   //
   ///**
   // * TODO Describe uvma_axis_base_vseq_c::write_mon_trn()
   // */
   //extern task write_mon_trn(ref uvma_axis_mon_trn_c trn);
   //
   ///**
   // * TODO Describe uvma_axis_base_vseq_c::get_mstr_mon_trn()
   // */
   //extern task get_mstr_mon_trn(output uvma_axis_mstr_mon_trn_c trn);
   //
   ///**
   // * TODO Describe uvma_axis_base_vseq_c::get_slv_mon_trn()
   // */
   //extern task get_slv_mon_trn(output uvma_axis_slv_mon_trn_c trn);
   
endclass : uvma_axis_base_vseq_c


function uvma_axis_base_vseq_c::new(string name="uvma_axis_base_vseq");
   
   super.new(name);
   
endfunction : new


//task uvma_axis_base_vseq_c::pre_start();
//   
//   cfg   = p_sequencer.cfg;
//   cntxt = p_sequencer.cntxt;
//   
//endtask : pre_start
//
//
//task uvma_axis_base_vseq_c::upstream_get_next_item(ref uvm_sequence_item req);
//   
//   p_sequencer.upstream_sqr_port.get_next_item(req);
//   
//endtask : upstream_get_next_item
//
//
//task uvma_axis_base_vseq_c::upstream_item_done(ref uvm_sequence_item req);
//   
//   p_sequencer.upstream_sqr_port.item_done(req);
//   
//endtask : upstream_item_done
//
//
//task uvma_axis_base_vseq_c::write_mon_trn(ref uvma_axis_mon_trn_c trn);
//   
//   p_sequencer.mon_trn_ap.write(trn);
//   
//endtask : write_mon_trn
//
//
//task uvma_axis_base_vseq_c::get_mstr_mon_trn(output uvma_axis_mstr_mon_trn_c trn);
//   
//   p_sequencer.mstr_mon_trn_fifo.get(trn);
//   
//endtask : get_mstr_mon_trn
//
//
//task uvma_axis_base_vseq_c::get_slv_mon_trn(output uvma_axis_slv_mon_trn_c trn);
//   
//   p_sequencer.slv_mon_trn_fifo.get(trn);
//   
//endtask : get_slv_mon_trn


`endif // __UVMA_AXIS_BASE_VSEQ_SV__
