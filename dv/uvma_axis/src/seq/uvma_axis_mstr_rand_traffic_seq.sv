// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_MSTR_RAND_TRAFFIC_SEQ_SV__
`define __UVMA_AXIS_MSTR_RAND_TRAFFIC_SEQ_SV__


/**
 * TODO Describe uvma_axis_mstr_rand_traffic_seq_c
 */
class uvma_axis_mstr_rand_traffic_seq_c extends uvma_axis_mstr_base_seq_c;
   
   // Knobs
   rand int unsigned  num_pkts;
   rand int unsigned  min_size;
   rand int unsigned  max_size;
   rand int unsigned  min_ipg ;
   rand int unsigned  max_ipg ;
   
   
   `uvm_object_utils_begin(uvma_axis_mstr_rand_traffic_seq_c)
      `uvm_field_int(num_pkts, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_size, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_size, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_ipg , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_ipg , UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      //soft num_pkts == uvma_axis_mstr_rand_traffic_seq_default_num_pkts;
   }
   
   constraint limits_cons {
      min_size >  0;
      max_size <= `UVM_PACKER_MAX_BYTES;
      min_ipg  <= max_ipg ;
      min_size <= max_size;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_mstr_rand_traffic_seq");
   
   /**
    * TODO Describe uvma_axis_mstr_rand_traffic_seq_c::body()
    */
   extern virtual task body();
   
endclass : uvma_axis_mstr_rand_traffic_seq_c


function uvma_axis_mstr_rand_traffic_seq_c::new(string name="uvma_axis_mstr_rand_traffic_seq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_mstr_rand_traffic_seq_c::body();
   
   int unsigned ipg;
   
   for (int unsigned pkt_num=0; pkt_num<num_pkts; pkt_num++) begin
      `uvm_info("AXIS_SEQ", $sformatf("Sending payload #%0d of %0d", pkt_num+1, num_pkts), UVM_MEDIUM)
      `uvm_do_with(req, {
         req.size inside {[min_size:max_size]};
      })
      
      ipg = $urandom_range(min_ipg, max_ipg);
      `uvm_info("AXIS_SEQ", $sformatf("Waiting %0d cycles before sending next payload", ipg), UVM_MEDIUM)
      repeat (ipg) begin
         @(cntxt.vif.drv_master_cb);
      end
   end
   
endtask : body


`endif // __UVMA_AXIS_MSTR_RAND_TRAFFIC_SEQ_SV__
