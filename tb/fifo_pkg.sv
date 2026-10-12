// -----------------------------------------------------------------------------
// fifo_pkg.sv
// All UVM testbench classes. `include order matters: each class must be
// defined before any class that uses it.
// -----------------------------------------------------------------------------
package fifo_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import fifo_params_pkg::*;

  // Agent
  `include "fifo_seq_item.sv"
  `include "fifo_sequencer.sv"
  `include "fifo_driver.sv"
  `include "fifo_monitor.sv"
  `include "fifo_agent.sv"

  // Environment
  `include "fifo_scoreboard.sv"
  `include "fifo_coverage.sv"
  `include "fifo_env.sv"

  // Stimulus
  `include "fifo_sequences.sv"

  // Tests
  `include "fifo_base_test.sv"
  `include "fifo_tests.sv"

endpackage
