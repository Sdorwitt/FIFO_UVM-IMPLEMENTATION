// Compile list for xrun. Paths are relative to sim/ (run xrun from here).
// Order: params -> RTL -> interface -> assertions -> UVM package -> top

+incdir+../tb
+incdir+../tb/agent
+incdir+../tb/env
+incdir+../tb/seq
+incdir+../tb/tests

../tb/fifo_params_pkg.sv
../rtl/fifo.sv
../tb/fifo_if.sv
../tb/fifo_sva.sv
../tb/fifo_pkg.sv
../tb/tb_top.sv
