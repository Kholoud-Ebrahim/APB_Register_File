class timer_0 extends uvm_reg;
    `uvm_object_utils(timer_0)

    rand uvm_reg_field   timer_y2r;
    rand uvm_reg_field   timer_r2g;
    rand uvm_reg_field   timer_g2y;

    function new(string name = "timer_0");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction :new
    
    function void build();
        timer_y2r = uvm_reg_field::type_id::create("timer_y2r");
        timer_r2g = uvm_reg_field::type_id::create("timer_r2g");
        timer_g2y = uvm_reg_field::type_id::create("timer_g2y");
    
        timer_y2r.configure(.parent(this),
                            .size(8),
                            .lsb_pos(0),
                            .access("RW"),
                            .volatile(0),
                            .reset(8'h34),
                            .has_reset(1),
                            .is_rand(1),
                            .individually_accessible(1));

        timer_r2g.configure(.parent(this),
                            .size(12),
                            .lsb_pos(8),
                            .access("RW"),
                            .volatile(0),
                            .reset(12'he12),
                            .has_reset(1),
                            .is_rand(1),
                            .individually_accessible(1));

        timer_g2y.configure(.parent(this),
                            .size(12),
                            .lsb_pos(20),
                            .access("RW"),
                            .volatile(0),
                            .reset(12'hcaf),
                            .has_reset(1),
                            .is_rand(1),
                            .individually_accessible(1));
    endfunction :build
endclass :timer_0