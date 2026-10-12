// -----------------------------------------------------------------------------
// fifo_coverage.sv
// Functional coverage. uvm_subscriber gives us a built-in analysis_export
// and a write() function to implement.
// -----------------------------------------------------------------------------
class fifo_coverage extends uvm_subscriber #(fifo_seq_item);
  `uvm_component_utils(fifo_coverage)

  fifo_seq_item item;

  covergroup fifo_cg;
    cp_wr_en : coverpoint item.wr_en;
    cp_rd_en : coverpoint item.rd_en;
    cx_wr_rd : cross cp_wr_en, cp_rd_en;
    // TODO: cp_full, cp_empty, cp_count (bins: 0, low, mid, DEPTH-1, DEPTH)
    // TODO: crosses such as write-while-full, read-while-empty,
    //       simultaneous read+write while full / empty
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    fifo_cg = new();
  endfunction

  function void write(fifo_seq_item t);
    item = t;
    fifo_cg.sample();
  endfunction

endclass
