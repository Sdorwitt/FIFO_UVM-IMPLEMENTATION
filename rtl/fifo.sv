// -----------------------------------------------------------------------------
// fifo.sv
// Synchronous (single-clock) FIFO.
//
// Behavior:
//   - A write is accepted only when !full; a read is accepted only when !empty.
//   - Simultaneous read + write is allowed; count stays the same.
//       * When full : only the read is accepted (write dropped).
//       * When empty: only the write is accepted (read ignored).
//   - rd_data is registered: data appears the cycle AFTER rd_en is sampled.
// -----------------------------------------------------------------------------
module fifo #(
  parameter int DATA_WIDTH = 8,
  parameter int DEPTH      = 16    // must be >= 2
) (
  input  logic                   clk,
  input  logic                   rst_n,

  input  logic                   wr_en,
  input  logic [DATA_WIDTH-1:0]  wr_data,

  input  logic                   rd_en,
  output logic [DATA_WIDTH-1:0]  rd_data,

  output logic                   full,
  output logic                   empty,
  output logic [$clog2(DEPTH):0] count
);

  localparam int AW = $clog2(DEPTH);

  logic [DATA_WIDTH-1:0] mem [DEPTH];
  logic [AW-1:0]         wr_ptr, rd_ptr;
  logic                  do_write, do_read;

  assign full     = (count == DEPTH);
  assign empty    = (count == 0);
  assign do_write = wr_en && !full;
  assign do_read  = rd_en && !empty;

  // Storage (not reset)
  always_ff @(posedge clk) begin
    if (do_write) mem[wr_ptr] <= wr_data;
  end

  // Pointers, count, read data
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      wr_ptr  <= '0;
      rd_ptr  <= '0;
      count   <= '0;
      rd_data <= '0;
    end else begin
      if (do_write)
        wr_ptr <= (wr_ptr == AW'(DEPTH-1)) ? '0 : wr_ptr + 1'b1;

      if (do_read) begin
        rd_data <= mem[rd_ptr];
        rd_ptr  <= (rd_ptr == AW'(DEPTH-1)) ? '0 : rd_ptr + 1'b1;
      end

      case ({do_write, do_read})
        2'b10:   count <= count + 1'b1;
        2'b01:   count <= count - 1'b1;
        default: count <= count;
      endcase
    end
  end

endmodule
