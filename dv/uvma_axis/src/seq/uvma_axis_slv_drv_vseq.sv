// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_SLV_DRV_VSEQ_SV__
`define __UVMA_AXIS_SLV_DRV_VSEQ_SV__


/**
 * TODO Describe uvma_axis_slv_drv_vseq_c
 */
class uvma_axis_slv_drv_vseq_c extends uvma_axis_base_vseq_c;
   
   `uvm_object_utils(uvma_axis_slv_drv_vseq_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_slv_drv_vseq");
   
   /**
    * TODO Describe uvma_axis_slv_drv_vseq_c::body()
    */
   extern virtual task body();
   
   /**
    * TODO Describe uvma_axis_slv_drv_vseq_c::drive_valid()
    */
   extern virtual task drive_valid();
   
   /**
    * TODO Describe uvma_axis_slv_drv_vseq_c::drive_idle()
    */
   extern virtual task drive_idle();
   
   /**
    * TODO Describe uvma_axis_slv_drv_vseq_c::wait_clk()
    */
   extern task wait_clk();
   
endclass : uvma_axis_slv_drv_vseq_c


function uvma_axis_slv_drv_vseq_c::new(string name="uvma_axis_slv_drv_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_slv_drv_vseq_c::body();
   
   `uvm_info("AXIS_SLV_DRV_VSEQ", "SLV driver virtual sequence has started", UVM_HIGH)
   forever begin
      fork
         begin
            `uvm_info("AXIS_SLV_DRV_VSEQ", "Waiting for post_reset", UVM_DEBUG)
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET) begin
               `uvm_info("AXIS_SLV_DRV_VSEQ", "Done waiting for post_reset", UVM_DEBUG)
               if (cntxt.vif.drv_slv_cb.tvalid === 1'b1) begin
                  drive_valid();
               end
               else begin
                  drive_idle();
               end
            end
         end
         
         begin
            wait (cntxt.reset_state == UVML_RESET_STATE_POST_RESET);
            wait (cntxt.reset_state != UVML_RESET_STATE_POST_RESET);
         end
      join_any
      disable fork;
   end
   
endtask : body


task uvma_axis_slv_drv_vseq_c::drive_valid();
   
   uvma_axis_slv_seq_item_c  req   ;
   int unsigned              pct_off = 100 - cfg.drv_slv_valid_ton;
   
   if ($urandom_range(1,100) > pct_off) begin
      `uvm_do_on_pri_with(req, p_sequencer.slv_sequencer, `UVMA_AXIS_SLV_DRV_SEQ_ITEM_PRI, {
         req.tready == 1;
      })
   end
   else begin
      `uvm_do_on_pri_with(req, p_sequencer.slv_sequencer, `UVMA_AXIS_SLV_DRV_SEQ_ITEM_PRI, {
         req.tready == 0;
      })
   end
   
endtask : drive_valid


task uvma_axis_slv_drv_vseq_c::drive_idle();
   
   uvma_axis_slv_seq_item_c  req   ;
   int unsigned              pct_off = 100 - cfg.drv_slv_idle_ton;
   
   if ($urandom_range(1,100) > pct_off) begin
      `uvm_do_on_pri_with(req, p_sequencer.slv_sequencer, `UVMA_AXIS_SLV_DRV_SEQ_ITEM_PRI, {
         req.tready == 1;
      })
   end
   else begin
      // Let idle sequence do its thing
      wait_clk();
   end
   
endtask : drive_idle


task uvma_axis_slv_drv_vseq_c::wait_clk();
   
   @(cntxt.vif.drv_slv_cb);
   
endtask : wait_clk


`endif // __UVMA_AXIS_SLV_DRV_VSEQ_SV__
