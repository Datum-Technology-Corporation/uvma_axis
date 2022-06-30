// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_IDLE_VSEQ_SV__
`define __UVMA_AXIS_IDLE_VSEQ_SV__


/**
 * TODO Describe uvma_axis_idle_vseq_c
 */
class uvma_axis_idle_vseq_c extends uvma_axis_base_vseq_c;
   
   `uvm_object_utils(uvma_axis_idle_vseq_c)
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_idle_vseq");
   
   /**
    * TODO Describe uvma_axis_idle_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_axis_idle_vseq_c::mstr()
    */
   extern task mstr();
   
   /**
    * TODO Describe uvma_axis_idle_vseq_c::slv()
    */
   extern task slv();
   
endclass : uvma_axis_idle_vseq_c


function uvma_axis_idle_vseq_c::new(string name="uvma_axis_idle_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_idle_vseq_c::body();
   
   `uvm_info("AXIS_IDLE_VSEQ", "Idle virtual sequence has started", UVM_HIGH)
   case (cfg.drv_mode)
      UVMA_AXIS_DRV_MODE_MSTR: mstr();
      UVMA_AXIS_DRV_MODE_SLV : slv ();
   endcase
   
endtask : body


task uvma_axis_idle_vseq_c::mstr();
   
   uvma_axis_mstr_seq_item_c  mstr_seq_item;
   
   forever begin
      `uvm_create_on(mstr_seq_item, p_sequencer.mstr_sequencer)
      // TODO Add support for cfg.drv_slv_valid_ton
      case (cfg.drv_idle)
         UVMA_AXIS_DRV_IDLE_ZEROS: begin
            `uvm_rand_send_pri_with(mstr_seq_item, `UVMA_AXIS_MSTR_IDLE_SEQ_ITEM_PRI, {
               tvalid == 0;
               tdata  == 0;
               tstrb  == 0;
               tkeep  == 0;
               tlast  == 0;
               tid    == 0;
               tdest  == 0;
               tuser  == 0;
            })
         end
         
         UVMA_AXIS_DRV_IDLE_RANDOM: begin
            `uvm_rand_send_pri_with(mstr_seq_item, `UVMA_AXIS_MSTR_IDLE_SEQ_ITEM_PRI, {
               tvalid == 0;
            })
         end
      endcase
   end
   
endtask : mstr


task uvma_axis_idle_vseq_c::slv();
   
    uvma_axis_slv_seq_item_c  slv_seq_item;
   
   forever begin
      `uvm_create_on(slv_seq_item, p_sequencer.slv_sequencer)
      `uvm_rand_send_pri_with(slv_seq_item, `UVMA_AXIS_SLV_IDLE_SEQ_ITEM_PRI, {
         tready == 0;
      })
   end
   
endtask : slv


`endif // __UVMA_AXIS_IDLE_VSEQ_SV__
