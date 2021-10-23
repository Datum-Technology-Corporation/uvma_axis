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


`ifndef __UVMA_AXIS_SLV_DRV_VSEQ_SV__
`define __UVMA_AXIS_SLV_DRV_VSEQ_SV__


/**
 * TODO Describe uvma_axis_slv_drv_vseq_c
 */
class uvma_axis_slv_drv_vseq_c extends uvma_axis_slv_base_vseq_c;
   
   `uvm_object_utils(uvma_axis_slv_drv_vseq_c)
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_slv_drv_vseq");
   
   /**
    * TODO Describe uvma_axis_slv_drv_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvma_axis_slv_drv_vseq_c


function uvma_axis_slv_drv_vseq_c::new(string name="uvma_axis_slv_drv_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_slv_drv_vseq_c::body();
   
   bit                       tready;
   uvma_axis_slv_seq_item_c  req   ;
   int unsigned              pct_off = 100 - cfg.drv_slv_on;
   
   forever begin
      randcase
         cfg.drv_slv_on : tready = 1;
         pct_off        : tready = 0;
      endcase
      
      `uvm_do_on_with(req, p_sequencer.slv_sequencer, {
         req.tready == local::tready;
      })
   end
   
endtask : body


`endif // __UVMA_AXIS_SLV_DRV_VSEQ_SV__
