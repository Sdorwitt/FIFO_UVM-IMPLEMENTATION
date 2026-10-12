// -----------------------------------------------------------------------------
// fifo_driver.sv
// Pulls items from the sequencer and drives them onto the interface pins.
// -----------------------------------------------------------------------------
class fifo_driver extends uvm_driver #(fifo_seq_item);
  `uvm_component_utils(fifo_driver)

  virtual fifo_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual fifo_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "virtual interface not set for driver")
  endfunction

  task run_phase(uvm_phase phase);
    // Idle values, then wait for reset to be released
    vif.drv_cb.wr_en   <= 1'b0;
    vif.drv_cb.wr_data <= '0;
    vif.drv_cb.rd_en   <= 1'b0;
    @(posedge vif.rst_n);

    forever begin
      seq_item_port.get_next_item(req);
      drive_item(req);
      seq_item_port.item_done();
    end
  endtask

  // Drive one item for one clock cycle
  task drive_item(fifo_seq_item item);
    // TODO: drive item.wr_en / item.wr_data / item.rd_en through vif.drv_cb
    @(vif.drv_cb);
  endtask

endclass
