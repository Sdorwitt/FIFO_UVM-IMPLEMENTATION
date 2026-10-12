// -----------------------------------------------------------------------------
// fifo_monitor.sv
// Passively samples the interface every clock and broadcasts a transaction
// on its analysis port. Never drives anything.
// -----------------------------------------------------------------------------
class fifo_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_monitor)

  virtual fifo_if vif;
  uvm_analysis_port #(fifo_seq_item) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap", this);
    if (!uvm_config_db #(virtual fifo_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "virtual interface not set for monitor")
  endfunction

  task run_phase(uvm_phase phase);
    // TODO: forever loop:
    //   - wait for @(vif.mon_cb), skip cycles while in reset
    //   - create a fifo_seq_item and fill every field from vif.mon_cb
    //   - ap.write(item)
    // Remember: rd_data is registered in the DUT, so the data for a read
    // accepted on cycle N shows up on cycle N+1.
  endtask

endclass
