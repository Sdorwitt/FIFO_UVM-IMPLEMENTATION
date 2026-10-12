// -----------------------------------------------------------------------------
// fifo_base_test.sv
// Builds the environment. Derived tests override run_phase to pick stimulus.
// -----------------------------------------------------------------------------
class fifo_base_test extends uvm_test;
  `uvm_component_utils(fifo_base_test)

  fifo_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = fifo_env::type_id::create("env", this);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

  // Fail the test if any UVM_ERROR/UVM_FATAL was reported
  function void report_phase(uvm_phase phase);
    uvm_report_server svr = uvm_report_server::get_server();
    super.report_phase(phase);
    if (svr.get_severity_count(UVM_ERROR) + svr.get_severity_count(UVM_FATAL) > 0)
      `uvm_info("RESULT", "*** TEST FAILED ***", UVM_NONE)
    else
      `uvm_info("RESULT", "*** TEST PASSED ***", UVM_NONE)
  endfunction

endclass
