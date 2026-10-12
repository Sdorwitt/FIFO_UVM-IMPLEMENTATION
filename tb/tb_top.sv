// -----------------------------------------------------------------------------
// tb_top.sv
// Static top: clock, reset, interface, DUT. Hands the interface to the UVM
// class world via config_db, then starts the test selected by +UVM_TESTNAME.
// -----------------------------------------------------------------------------
module tb_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import fifo_params_pkg::*;
  import fifo_pkg::*;

  logic clk;
  logic rst_n;

  // 100 MHz clock
  initial clk = 1'b0;
  always #5 clk = ~clk;

  // Reset: asserted for 5 cycles
  initial begin
    rst_n = 1'b0;
    repeat (5) @(posedge clk);
    rst_n = 1'b1;
  end

  fifo_if vif (.clk(clk), .rst_n(rst_n));

  fifo #(
    .DATA_WIDTH (DATA_WIDTH),
    .DEPTH      (DEPTH)
  ) dut (
    .clk     (clk),
    .rst_n   (rst_n),
    .wr_en   (vif.wr_en),
    .wr_data (vif.wr_data),
    .rd_en   (vif.rd_en),
    .rd_data (vif.rd_data),
    .full    (vif.full),
    .empty   (vif.empty),
    .count   (vif.count)
  );

  initial begin
    uvm_config_db #(virtual fifo_if)::set(null, "uvm_test_top.*", "vif", vif);
    run_test();
  end

  // Waveform dump for SimVision: run with +WAVES
  initial begin
    if ($test$plusargs("WAVES")) begin
      $shm_open("waves.shm");
      $shm_probe(tb_top, "AS");
    end
  end

endmodule
