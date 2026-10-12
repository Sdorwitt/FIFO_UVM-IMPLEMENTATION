// -----------------------------------------------------------------------------
// fifo_scoreboard.sv
// Reference model + checker. Receives every monitored transaction and
// compares DUT behavior against an SV queue model of the FIFO.
// -----------------------------------------------------------------------------
class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)

  uvm_analysis_imp #(fifo_seq_item, fifo_scoreboard) item_imp;

  // Reference model
  bit [DATA_WIDTH-1:0] model_q[$];

  int unsigned num_checks;
  int unsigned num_errors;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_imp = new("item_imp", this);
  endfunction

  // Called by the monitor's analysis port for every transaction
  function void write(fifo_seq_item item);
    // TODO:
    //   - check item.full / item.empty / item.count against model_q.size()
    //   - on an accepted write, push item.wr_data into model_q
    //   - on an accepted read, pop expected data and compare with rd_data
    //     (account for the 1-cycle rd_data latency)
    //   - `uvm_error on mismatch, count checks/errors
  endfunction

  function void check_phase(uvm_phase phase);
    super.check_phase(phase);
    // TODO: decide whether leftover entries in model_q are an error
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCB", $sformatf("checks=%0d errors=%0d", num_checks, num_errors), UVM_LOW)
  endfunction

endclass
