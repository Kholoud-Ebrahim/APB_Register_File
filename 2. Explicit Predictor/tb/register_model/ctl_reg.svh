class ctl_reg extends uvm_reg;
    `uvm_object_utils(ctl_reg)

    rand uvm_reg_field   en;
    rand uvm_reg_field   bl_y;
    rand uvm_reg_field   bl_r;
    rand uvm_reg_field   profile;

    covergroup cov_en;
        option.per_instance = 1;
        coverpoint en.value[0] {
            bins en_lo = {0};
            bins en_hi = {1};
        }
    endgroup :cov_en

    covergroup cov_bl_y;
        option.per_instance = 1;
        coverpoint bl_y.value[1] {
            bins bly_lo = {0};
        }
    endgroup :cov_bl_y

    covergroup cov_bl_r;
        option.per_instance = 1;
        coverpoint bl_r.value[1] {
            bins blr_lo = {0};
        }
    endgroup :cov_bl_r

    covergroup cov_profile;
        option.per_instance = 1;
        coverpoint profile.value[1] {
            bins profile_lo = {0};
        }
    endgroup :cov_profile

    function new(string name = "ctl_reg");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if(has_coverage(UVM_CVR_FIELD_VALS)) begin
            cov_en      = new();
            cov_bl_y    = new();
            cov_bl_r    = new();
            cov_profile = new();
        end
    endfunction :new
    
    function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        cov_en.sample();
        cov_bl_y.sample();
        cov_bl_r.sample();
        cov_profile.sample();
    endfunction :sample

    function void sample_values();
        super.sample_values();
        cov_en.sample();
        cov_bl_y.sample();
        cov_bl_r.sample();
        cov_profile.sample();
    endfunction :sample_values
    
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