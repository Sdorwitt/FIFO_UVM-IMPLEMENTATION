Welcome to my SystemVerilog/UVM implementation project

A synchronous FIFO and a UVM testbench for it, targeting Cadence Xcelium (xrun).

## Layout

```
rtl/fifo.sv                 DUT: parameterized synchronous FIFO
tb/fifo_params_pkg.sv       DATA_WIDTH / DEPTH shared by DUT, interface and classes
tb/fifo_if.sv               Interface with driver/monitor clocking blocks
tb/fifo_sva.sv              Assertions, bound into the DUT with `bind`
tb/fifo_pkg.sv              Package that includes all UVM classes
tb/agent/                   seq_item, sequencer, driver, monitor, agent
tb/env/                     scoreboard, coverage, env
tb/seq/                     sequences
tb/tests/                   base test + concrete tests
tb/tb_top.sv                Clock, reset, DUT, interface, run_test()
sim/files.f                 Compile list
sim/Makefile                xrun targets
```

## Running

```
cd sim
make run TEST=fifo_rand_test SEED=1
make gui TEST=fifo_rand_test
make cov TEST=fifo_rand_test && make imc
```
