# Project context

Learning project: practicing design verification by building a synchronous FIFO
and a UVM testbench for it, run with Cadence Xcelium (`xrun -uvm`), SimVision and IMC.
The goal is for the user to write the verification logic themselves; explain
concepts and review their work rather than filling in TODOs unasked.

## Current state

- `rtl/fifo.sv` and `tb/fifo_if.sv` are complete. Neither has been compiled yet
  (they were written on a machine without Xcelium). First step on the Xcelium
  machine: `cd sim && make run` and fix any compile errors.
- All UVM classes have their boilerplate (factory registration, phases,
  config_db, connections). The verification logic is left as `TODO`s, in the
  suggested order:
  1. driver `drive_item()`
  2. monitor `run_phase()`
  3. scoreboard `write()` (queue reference model)
  4. coverage coverpoints and crosses
  5. remaining SVA properties and cover properties
  6. directed sequences and tests (fill/drain, overflow, underflow)

## Design decisions

- One agent drives both the write and read ports, because the FIFO has one clock.
  Split it into write and read agents when moving on to an async FIFO.
- One `fifo_seq_item` = one clock cycle of stimulus plus the observed outputs.
- DUT: a write while full is dropped and a read while empty is ignored.
  Simultaneous read and write is allowed. `rd_data` is registered, so it
  appears one cycle after `rd_en`.
- `tb/fifo_params_pkg.sv` holds `DATA_WIDTH`/`DEPTH` for the DUT, the interface
  and the classes, so `virtual fifo_if` types always match.
- Assertions live in `tb/fifo_sva.sv` and are attached to the DUT with `bind`.
