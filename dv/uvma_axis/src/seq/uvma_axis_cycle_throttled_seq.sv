// Copyright 2021 Datum Technology Corporation
// 
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.


`ifndef __UVMA_AXIS_CYCLE_THROTTLED_SEQ_SV__
`define __UVMA_AXIS_CYCLE_THROTTLED_SEQ_SV__


/**
 * TODO Describe uvma_axis_cycle_throttled_seq_c
 */
class uvma_axis_cycle_throttled_seq_c extends uvma_axis_cycle_base_seq_c;
   
   // Knobs
   rand int unsigned  pct_bus_usage;
   
   // Fields
   bit [7:0]  payload_bytes[$];
   
   
   `uvm_object_utils_begin(uvma_axis_cycle_throttled_seq_c)
      `uvm_field_int(pct_bus_usage, UVM_DEFAULT)
      
      `uvm_field_queue_int(payload_bytes, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft pct_bus_usage == uvma_axis_cycle_throttle_seq_default_pct_bus_usage;
   }
   
   constraint limits_cons {
      pct_bus_usage <= 100;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_cycle_throttled_seq");
   
   /**
    * TODO Describe uvma_axis_cycle_throttled_seq_c::drive_payload()
    */
   extern virtual task drive_payload(ref uvma_axis_seq_item_c payload);
   
endclass : uvma_axis_cycle_throttled_seq_c


function uvma_axis_cycle_throttled_seq_c::new(string name="uvma_axis_cycle_throttled_seq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_cycle_throttled_seq_c::drive_payload(ref uvma_axis_seq_item_c payload);
   
   foreach (payload.data[ii]) begin
      payload_bytes.push_back(payload.data[ii]);
   end
   
   do begin
      `uvm_create(req)
      
      randcase
         pct_bus_usage : begin
            req.tvalid = 1;
            req.tuser  = payload.tuser;
            req.tdata = new[p_sequencer.cfg.data_bus_width];
            foreach (req.tdata[ii]) begin
               if (payload_bytes.size() > 0) begin
                  req.tdata[ii] = payload_bytes.pop_front();
                  req.tkeep[ii] = 1;
               end
               else begin
                  req.tkeep[ii] = 0;
               end
            end
         end
         
         (100-pct_bus_usage) : begin
            req.tvalid = 0;
         end
      endcase
      
      `uvm_send(req)
   end while (payload_bytes.size() > 0);
   
endtask : drive_payload


`endif // __UVMA_AXIS_CYCLE_THROTTLED_SEQ_SV__
