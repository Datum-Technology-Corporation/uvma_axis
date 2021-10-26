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


`ifndef __UVMA_AXIS_RAND_TRAFFIC_SEQ_SV__
`define __UVMA_AXIS_RAND_TRAFFIC_SEQ_SV__


/**
 * TODO Describe uvma_axis_rand_traffic_vseq_c
 */
class uvma_axis_rand_traffic_vseq_c extends uvma_axis_base_vseq_c;
   
   // Knobs
   rand int unsigned  num_transfers; ///< 
   rand int unsigned  min_size     ; ///< 
   rand int unsigned  max_size     ; ///< 
   rand int unsigned  min_gap      ; ///< 
   rand int unsigned  max_gap      ; ///< 
   
   
   `uvm_object_utils_begin(uvma_axis_rand_traffic_vseq_c)
      `uvm_field_int(num_transfers, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_size     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_size     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_gap      , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_gap      , UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   /*constraint defaults_cons {
      //soft num_transfers == uvma_axis_rand_traffic_vseq_default_num_transfers;
   }*/
   
   constraint limits_cons {
      min_size >  0;
      max_size <= 512;
      min_gap  <= max_gap ;
      min_size <= max_size;
      num_transfers <= 100;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_rand_traffic_vseq");
   
   /**
    * TODO Describe uvma_axis_rand_traffic_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvma_axis_rand_traffic_vseq_c


function uvma_axis_rand_traffic_vseq_c::new(string name="uvma_axis_rand_traffic_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_rand_traffic_vseq_c::body();
   
   int unsigned          gap;
   uvma_axis_seq_item_c  req;
   
   for (int unsigned ii=0; ii<num_transfers; ii++) begin
      `uvm_info("AXIS_SEQ", $sformatf("Sending payload segment #%0d of %0d", ii+1, num_transfers), UVM_MEDIUM)
      `uvm_do_with(req, {
         req.size inside {[min_size:max_size]};
      })
      
      gap = $urandom_range(min_gap, max_gap);
      `uvm_info("AXIS_SEQ", $sformatf("Waiting %0d cycles before sending next segment", gap), UVM_MEDIUM)
      repeat (gap) begin
         @(cntxt.vif.drv_mstr_cb);
      end
   end
   
endtask : body


`endif // __UVMA_AXIS_RAND_TRAFFIC_SEQ_SV__
