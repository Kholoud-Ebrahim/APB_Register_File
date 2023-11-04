class stat_reg extends uvm_reg;
    `uvm_object_utils(stat_reg)

    uvm_reg_field   stat;

    function new(string name = "stat_reg");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction :new

    function void build();
        stat      = uvm_reg_field::type_id::create("stat");

        stat.configure(.parent(this),
                       .size(2),
                       .lsb_pos(0),
                       .access("RO"),
                       .volatile(0),
                       .reset(2'h0),
                       .has_reset(1),
                       .is_rand(0),
                       .individually_accessible(1));
    endfunction :build
endclass :stat_reg