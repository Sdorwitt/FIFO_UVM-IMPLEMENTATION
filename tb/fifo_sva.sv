// -----------------------------------------------------------------------------
// fifo_sva.sv
// Assertions for the FIFO. Attached to every fifo instance with `bind`
// (bottom of file), so the RTL stays untouched.
// -----------------------------------------------------------------------------
module fifo_sva #(
  parameter int DATA_WIDTH = 8,
  parameter int DEPTH      = 16
) (
  input logic                   clk,
  input logic                   rst_n,
  input logic                   wr_en,
  input logic [DATA_WIDTH-1:0]  wr_data,
  input logic                   rd_en,
  input logic [DATA_WIDTH-1:0]  rd_data,
  input logic                   full,
  input logic                   empty,
  input logic [$clog2(DEPTH):0] count
);

  default clocking @(posedge clk); endclocking
  default disable iff (!rst_n);

  // Example: full and empty are never asserted together
  a_not_full_and_empty: assert property (!(full && empty))
    else $error("SVA: full and empty asserted together");

  // Example: write while full (and no read) must not change count
  a_no_overflow: assert property ((full && wr_en && !rd_en) |=> $stable(count))
    else $error("SVA: count changed on write while full");

  // TODO: count never exceeds DEPTH
  // TODO: read while empty (and no write) must not change count
  // TODO: count increments by 1 on an accepted write-only cycle
  // TODO: count decrements by 1 on an accepted read-only cycle
  // TODO: full == (count == DEPTH), empty == (count == 0)
  // TODO: empty is asserted out of reset (needs its own property without
  //       the default disable iff)

  // TODO: cover properties, e.g.
  //   c_full:         cover property (full);
  //   c_full_to_empty: FIFO goes from full to empty
  //   c_rw_when_full:  simultaneous read + write while full

endmodule

// Insert fifo_sva into every fifo instance; parameters and ports resolve in
// the fifo's scope, so .* picks up its port names directly.
bind fifo fifo_sva #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) u_fifo_sva (.*);
