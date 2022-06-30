// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_AXIS_TRANSPORT_VSEQ_SV__
`define __UVMA_AXIS_TRANSPORT_VSEQ_SV__


/**
 * TODO Describe uvma_axis_transport_vseq_c
 */
class uvma_axis_transport_vseq_c extends uvma_axis_base_vseq_c;
   
   rand uvma_axis_tdest_b_t  tdest; ///< 
   rand uvma_axis_tuser_b_t  tuser; ///< 
   
   
   `uvm_object_utils_begin(uvma_axis_transport_vseq_c)
      `uvm_field_int(tdest, UVM_DEFAULT)
      `uvm_field_int(tuser, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_axis_transport_vseq");
   
   /**
    * Gets new higher-layer sequence items
    */
   extern virtual task body();
   
endclass : uvma_axis_transport_vseq_c


function uvma_axis_transport_vseq_c::new(string name="uvma_axis_transport_vseq");
   
   super.new(name);
   
endfunction : new


task uvma_axis_transport_vseq_c::body();
   
   uvm_sequence_item  payload;
   bit [7:0]          payload_bytes[];
   
   `uvm_info("AXIS_TRANSPORT_VSEQ", "Transport virtual sequence has started", UVM_HIGH)
   forever begin
      upstream_get_next_item(payload);
      void'(payload.pack_bytes(payload_bytes));
      
      // Create seq item
      `uvm_create_on(req, p_sequencer)
      req.tdest = tdest;
      foreach (req.data[ii]) begin
         req.data[ii] = payload_bytes[ii];
      end
      req.tuser = tuser;
      req.size  = payload_bytes.size();
      req.tid   = $urandom();
      
      `uvm_send(req)
      upstream_item_done(payload);
   end
   
endtask : body


`endif // __UVMA_AXIS_TRANSPORT_VSEQ_SV__
