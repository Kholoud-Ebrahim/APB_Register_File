class rf_sequence_item extends uvm_sequence_item;
    bit [SIZE-1:0]   paddr;
    bit [SIZE-1:0]   pwdata;
    bit              psel;
    bit              pwrite;
    bit              penable;
    bit [SIZE-1:0]   prdata;

    `uvm_object_utils_begin(rf_sequence_item)
        `uvm_field_int(paddr, UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(pwdata, UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(psel, UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(pwrite, UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(penable, UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(prdata, UVM_DEFAULT | UVM_HEX)
    `uvm_object_utils_end

    function new(string name = "rf_sequence_item");
        super.new(name);
    endfunction :new
endclass :rf_sequence_item