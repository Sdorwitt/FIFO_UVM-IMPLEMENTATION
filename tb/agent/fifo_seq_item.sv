// -----------------------------------------------------------------------------
// fifo_seq_item.sv
// One transaction = one clock cycle of activity on the FIFO ports.
//   Stimulus fields (rand) are driven by the driver.
//   Observed fields are filled in by the monitor.
// -----------------------------------------------------------------------------
class fifo_seq_item extends uvm_sequence_item;
  `uvm_object_utils(fifo_seq_item)

  // Stimulus
  rand bit                  wr_en;
  rand bit [DATA_WIDTH-1:0] wr_data;
  rand bit                  rd_en;

  // Observed (filled in by monitor)
  bit [DATA_WIDTH-1:0]      rd_data;
  bit                       full;
  bit                       empty;
  bit [CNT_W-1:0]           count;

  // TODO: add constraints, e.g. weight wr_en/rd_en distributions
  //   constraint c_wr_rd { wr_en dist {1 := 6, 0 := 4}; }

  function new(string name = "fifo_seq_item");
    super.new(name);
  endfunction

  virtual function string convert2string();
    return $sformatf("wr_en=%0b wr_data=0x%0h rd_en=%0b | rd_data=0x%0h full=%0b empty=%0b count=%0d",
                     wr_en, wr_data, rd_en, rd_data, full, empty, count);
  endfunction

  // TODO: implement do_copy() and do_compare()

endclass
