class apb_rf_base_test extends uvm_test;
    `uvm_component_utils(apb_rf_base_test)

    apb_rf_env  rf_env_h;

    function new(string name = "apb_rf_base_test", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        rf_env_h = apb_rf_env::type_id::create("rf_env_h", this);
    endfunction :build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);

        uvm_top.print_topology();
    endfunction :end_of_elaboration_phase
endclass :apb_rf_base_test