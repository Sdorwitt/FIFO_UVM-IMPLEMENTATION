# -----------------------------------------------------------------------------
# Cadence Xcelium (xrun) flow. Run from the sim/ directory.
#
#   make run  TEST=fifo_rand_test SEED=1    # batch run
#   make gui  TEST=fifo_rand_test           # SimVision interactive
#   make cov  TEST=fifo_rand_test           # with code + functional coverage
#   make imc                                # open coverage in IMC
#   make clean
# -----------------------------------------------------------------------------

TEST      ?= fifo_rand_test
SEED      ?= 1
VERBOSITY ?= UVM_MEDIUM

XRUN_OPTS = -uvm -sv -timescale 1ns/1ps -access +rwc \
            -f files.f -top tb_top \
            +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=$(VERBOSITY) \
            -svseed $(SEED) -l $(TEST)_$(SEED).log

.PHONY: run gui cov imc clean

run:
	xrun $(XRUN_OPTS)

gui:
	xrun $(XRUN_OPTS) -gui +WAVES

cov:
	xrun $(XRUN_OPTS) -coverage all -covoverwrite -covtest $(TEST)_$(SEED)

imc:
	imc -load cov_work/scope/$(TEST)_$(SEED)

clean:
	rm -rf xcelium.d INCA_libs cov_work waves.shm .simvision \
	       *.log *.history *.key *.diag *.err
