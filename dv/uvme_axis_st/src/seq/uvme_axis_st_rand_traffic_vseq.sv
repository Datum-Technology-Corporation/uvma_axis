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


`ifndef __UVME_AXIS_ST_RAND_TRAFFIC_VSEQ_SV__
`define __UVME_AXIS_ST_RAND_TRAFFIC_VSEQ_SV__


/**
 * TODO Describe uvme_axis_st_rand_traffic_vseq_c
 */
class uvme_axis_st_rand_traffic_vseq_c extends uvme_axis_st_base_vseq_c;
   
   // Knobs
   rand int unsigned  num_transfers;
   rand int unsigned  min_size     ;
   rand int unsigned  max_size     ;
   rand int unsigned  min_ipg      ;
   rand int unsigned  max_ipg      ;
   
   // Sequences
   rand uvma_axis_rand_traffic_seq_c  mstr_seq;
   
   
   `uvm_object_utils_begin(uvme_axis_st_rand_traffic_vseq_c)
      `uvm_field_int(num_transfers, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_size     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_size     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(min_ipg      , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(max_ipg      , UVM_DEFAULT + UVM_DEC)
      
      `uvm_field_object(mstr_seq, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      //soft num_transfers       == uvme_axis_st_rand_traffic_vseq_default_num_transfers     ;
      //soft pct_bus_usage  == uvme_axis_st_rand_traffic_vseq_default_pct_bus_usage;
   }
   
   constraint limits_cons {
      min_ipg  <= max_ipg ;
      min_size <= max_size;
      pct_ton > 0;
      100 == (pct_ton + pct_toff);
      min_size >  0;
      max_size <= `UVM_PACKER_MAX_BYTES;
      pct_bus_usage > 0;
      pct_bus_usage <= 100;
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_axis_st_rand_traffic_vseq");
   
   /**
    * TODO Describe uvme_axis_st_rand_traffic_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvme_axis_st_rand_traffic_vseq_c


function uvme_axis_st_rand_traffic_vseq_c::new(string name="uvme_axis_st_rand_traffic_vseq");
   
   super.new(name);
   
endfunction : new


task uvme_axis_st_rand_traffic_vseq_c::body();
   
   `uvm_do_on_with(mstr_seq, p_sequencer.mstr_vsequencer, {
      mstr_seq.num_transfers == local::num_transfers;
      mstr_seq.min_size == local::min_size;
      mstr_seq.max_size == local::max_size;
      mstr_seq.min_ipg  == local::min_ipg ;
      mstr_seq.max_ipg  == local::max_ipg ;
   })
   
endtask : body


`endif // __UVME_AXIS_ST_RAND_TRAFFIC_VSEQ_SV__
