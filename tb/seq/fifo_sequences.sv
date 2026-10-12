// -----------------------------------------------------------------------------
// fifo_sequences.sv
// Stimulus. Each sequence generates fifo_seq_items (one per clock cycle).
// -----------------------------------------------------------------------------

// Base: common knobs for all FIFO sequences
class fifo_base_seq extends uvm_sequence #(fifo_seq_item);
  `uvm_object_utils(fifo_base_seq)

  int unsigned num_items = 100;

  function new(string name = "fifo_base_seq");
    super.new(name);
  endfunction

endclass

// Fully random reads and writes
class fifo_rand_seq extends fifo_base_seq;
  `uvm_object_utils(fifo_rand_seq)

  function new(string name = "fifo_rand_seq");
    super.new(name);
  endfunction

  task body();
    repeat (num_items) begin
      req = fifo_seq_item::type_id::create("req");
      start_item(req);
      if (!req.randomize())
        `uvm_error("RAND", "fifo_seq_item randomization failed")
      finish_item(req);
    end
  endtask

endclass

// TODO: fifo_write_only_seq  - writes only (rd_en == 0), e.g. fill to full
// TODO: fifo_read_only_seq   - reads only (wr_en == 0), e.g. drain to empty
// TODO: fifo_fill_drain_seq  - fill completely, then drain completely
// TODO: fifo_overflow_seq    - keep writing past full
// TODO: fifo_underflow_seq   - keep reading past empty
// Hint: use req.randomize() with { wr_en == 1; rd_en == 0; }
