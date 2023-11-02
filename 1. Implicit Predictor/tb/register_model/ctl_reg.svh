class ctl_reg extends uvm_reg;
    `uvm_object_utils(ctl_reg)

    rand uvm_reg_field   en;
    rand uvm_reg_field   bl_y;
    rand uvm_reg_field   bl_r;
    rand uvm_reg_field   profile;

    function new(string name = "ctl_reg");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction :new
    
    function void build();
        en      = uvm_reg_field::type_id::create("en");
        bl_y    = uvm_reg_field::type_id::create("bl_y");
        bl_r    = uvm_reg_field::type_id::create("bl_r");
        profile = uvm_reg_field::type_id::create("profile");

        en.configure(.parent(this),
                     .size(1),
                     .lsb_pos(0),
                     .access("RW"),
                     .volatile(0),
                     .reset(1'h0),
                     .has_reset(1),
                     .is_rand(1),
                     .individually_accessible(1));

        bl_y.configure(.parent(this),
                       .size(1),
                       .lsb_pos(1),
                       .access("RW"),
                       .volatile(0),
                       .reset(1'h0),
                       .has_reset(1),
                       .is_rand(1),
                       .individually_accessible(1));

        bl_r.configure(.parent(this),
                       .size(1),
                       .lsb_pos(2),
                       .access("RW"),
                       .volatile(0),
                       .reset(1'h0),
                       .has_reset(1),
                       .is_rand(1),
                       .individually_accessible(1));
                     
        profile.configure(.parent(this),
                          .size(1),
                          .lsb_pos(3),
                          .access("RW"),
                          .volatile(0),
                          .reset(1'h0),
                          .has_reset(1),
                          .is_rand(1),
                          .individually_accessible(1));
    endfunction :build
endclass :ctl_reg