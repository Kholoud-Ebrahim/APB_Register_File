class rf_agent extends uvm_agent;
    `uvm_component_utils(rf_agent)

    rf_sequencer  rf_sqr;
    rf_driver     rf_drv;
    rf_monitor    rf_mon;

    function new(string name = "rf_agent", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        rf_sqr = rf_sequencer::type_id::create("rf_sqr", this);
        rf_drv = rf_driver::type_id::create("rf_drv", this);
        rf_mon = rf_monitor::type_id::create("rf_mon", this);
    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        rf_drv.seq_item_port.connect(rf_sqr.seq_item_export);
    endfunction :connect_phase
endclass :rf_agent