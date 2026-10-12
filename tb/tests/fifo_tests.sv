// -----------------------------------------------------------------------------
// fifo_tests.sv
// Concrete tests. Select one at runtime with +UVM_TESTNAME=<class name>.
// -----------------------------------------------------------------------------

class fifo_rand_test extends fifo_base_test;
  `uvm_component_utils(fifo_rand_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    fifo_rand_seq seq = fifo_rand_seq::type_id::create("seq");
    phase.raise_objection(this);
    seq.start(env.agt.sqr);
    #100;   // let the last transactions propagate through monitor/scoreboard
    phase.drop_objection(this);
  endtask

endclass

// TODO: one test per directed sequence (fifo_fill_drain_test, fifo_overflow_test, ...)
