class rf_sequencer extends uvm_sequencer #(rf_sequence_item);
    `uvm_component_utils(rf_sequencer)

    function new(string name = "rf_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction :new
endclass :rf_sequencer