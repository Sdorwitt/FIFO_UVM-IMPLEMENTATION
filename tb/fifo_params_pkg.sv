// -----------------------------------------------------------------------------
// fifo_params_pkg.sv
// Single source of truth for DUT parameters. Used by tb_top (to parameterize
// the DUT and interface), fifo_if, and the UVM classes in fifo_pkg.
// -----------------------------------------------------------------------------
package fifo_params_pkg;

  parameter int DATA_WIDTH = 8;
  parameter int DEPTH      = 16;
  parameter int CNT_W      = $clog2(DEPTH) + 1;   // width of the count output

endpackage
