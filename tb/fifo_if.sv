// -----------------------------------------------------------------------------
// fifo_if.sv
// Interface between the UVM testbench and the FIFO DUT.
//
//   drv_cb : used by the driver. Outputs are driven 1 time unit after the
//            clock edge, so the DUT samples them cleanly on the next edge.
//   mon_cb : used by the monitor. Inputs are sampled just before the clock
//            edge (#1step), i.e. the values the DUT saw on that edge.
// -----------------------------------------------------------------------------
interface fifo_if (input logic clk, input logic rst_n);

  import fifo_params_pkg::*;

  logic                  wr_en;
  logic [DATA_WIDTH-1:0] wr_data;
  logic                  rd_en;
  logic [DATA_WIDTH-1:0] rd_data;
  logic                  full;
  logic                  empty;
  logic [CNT_W-1:0]      count;

  clocking drv_cb @(posedge clk);
    default input #1step output #1;
    output wr_en, wr_data, rd_en;
    input  rd_data, full, empty, count;
  endclocking

  clocking mon_cb @(posedge clk);
    default input #1step;
    input wr_en, wr_data, rd_en, rd_data, full, empty, count;
  endclocking

  modport DUT (input  clk, rst_n, wr_en, wr_data, rd_en,
               output rd_data, full, empty, count);
  modport DRV (clocking drv_cb, input rst_n);
  modport MON (clocking mon_cb, input rst_n);

endinterface
