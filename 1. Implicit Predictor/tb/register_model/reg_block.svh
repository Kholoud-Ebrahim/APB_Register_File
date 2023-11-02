class reg_block extends uvm_reg_block;
    `uvm_object_utils(reg_block)

    rand ctl_reg    ctl_reg_h;
    rand stat_reg   stat_reg_h;
    rand timer_0    timer_0_h;
    rand timer_1    timer_1_h;

    function new(string name = "reg_block");
        super.new(name, UVM_NO_COVERAGE);
    endfunction :new

    function void build();
        ctl_reg_h  = ctl_reg::type_id::create("ctl_reg_h");
        stat_reg_h = stat_reg::type_id::create("stat_reg_h");
        timer_0_h  = timer_0::type_id::create("timer_0_h");
        timer_1_h  = timer_1::type_id::create("timer_1_h");

        ctl_reg_h.build();
        stat_reg_h.build();
        timer_0_h.build();
        timer_1_h.build();

        ctl_reg_h.configure(this);
        stat_reg_h.configure(this);
        timer_0_h.configure(this);
        timer_1_h.configure(this);

        default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN);
        default_map.add_reg(ctl_reg_h , 'h0, "RW");
        default_map.add_reg(timer_0_h , 'h4, "RW");
        default_map.add_reg(timer_1_h , 'h8, "RW");
        default_map.add_reg(stat_reg_h, 'hc, "RO");

        default_map.set_auto_predict(1);
        lock_model();
    endfunction :build
endclass :reg_block