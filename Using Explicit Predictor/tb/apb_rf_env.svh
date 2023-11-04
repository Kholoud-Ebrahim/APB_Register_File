class apb_rf_env extends uvm_env;
    `uvm_component_utils(apb_rf_env)

    rf_agent        rf_agent_h;
    apb_adapter     apb_adapter_h;
    reg_block       reg_block_h;
    apb_rf_scb      rf_scb;
    uvm_reg_predictor#(rf_sequence_item)   predictor_h;

    function new(string name = "apb_rf_env", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        rf_agent_h    = rf_agent::type_id::create("rf_agent_h", this);
        apb_adapter_h = apb_adapter::type_id::create("apb_adapter_h");
        reg_block_h   = reg_block::type_id::create("reg_block_h");
        reg_block_h.build();
        rf_scb       = apb_rf_scb::type_id::create("rf_scb", this);
        predictor_h  = uvm_reg_predictor#(rf_sequence_item)::type_id::create("predictor_h", this);

    endfunction :build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        rf_agent_h.rf_mon.mon_port.connect(rf_scb.scb_imp);

        predictor_h.adapter = apb_adapter_h;
        predictor_h.map     = reg_block_h.default_map;
        rf_agent_h.rf_mon.mon_port.connect(predictor_h.bus_in);

        reg_block_h.default_map.set_sequencer(.sequencer(rf_agent_h.rf_sqr), .adapter(apb_adapter_h));
        reg_block_h.default_map.set_base_addr(0);

    endfunction :connect_phase
endclass :apb_rf_env