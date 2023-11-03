class timer_1 extends uvm_reg;
    `uvm_object_utils(timer_1)

    rand uvm_reg_field   timer_y2r;
    rand uvm_reg_field   timer_r2g;
    rand uvm_reg_field   timer_g2y;

    covergroup cov_timer_1_y2r;
        option.per_instance = 1;
        coverpoint timer_y2r.value[7:0] {
            bins t1_y2r_lo = {[0:{4{1'b1}}-1]};
            bins t1_y2r_hi = {[{4{1'b1}}:{8{1'b1}}]};
        }
    endgroup :cov_timer_1_y2r

    covergroup cov_timer_1_r2g;
        option.per_instance = 1;
        coverpoint timer_r2g.value[19:8] {
            bins t1_r2g_lo = {[0:{6{1'b1}}-1]};
        }
    endgroup :cov_timer_1_r2g

    covergroup cov_timer_1_g2y;
        option.per_instance = 1;
        coverpoint timer_g2y.value[31:20] {
            bins t1_g2y_lo = {[0:{6{1'b1}}-1]};
        }
    endgroup :cov_timer_1_g2y

    function new(string name = "timer_1");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if(has_coverage(UVM_CVR_FIELD_VALS)) begin
            cov_timer_1_y2r = new();
            cov_timer_1_r2g = new();
            cov_timer_1_g2y = new();
        end
    endfunction :new

    function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        cov_timer_1_y2r.sample();
        cov_timer_1_r2g.sample();
        cov_timer_1_g2y.sample();
    endfunction :sample

    function void sample_values();
        super.sample_values();
        cov_timer_1_y2r.sample();
        cov_timer_1_r2g.sample();
        cov_timer_1_g2y.sample();
    endfunction :sample_values
    
    function void build();
        timer_y2r = uvm_reg_field::type_id::create("timer_y2r");
        timer_r2g = uvm_reg_field::type_id::create("timer_r2g");
        timer_g2y = uvm_reg_field::type_id::create("timer_g2y");
    
        timer_y2r.configure(.parent(this),
                            .size(8),
                            .lsb_pos(0),
                            .access("RW"),
                            .volatile(0),
                            .reset(8'h78),
                            .has_reset(1),
                            .is_rand(1),
                            .individually_accessible(1));

        timer_r2g.configure(.parent(this),
                            .size(12),
                            .lsb_pos(8),
                            .access("RW"),
                            .volatile(0),
                            .reset(12'he56),
                            .has_reset(1),
                            .is_rand(1),
                            .individually_accessible(1));

        timer_g2y.configure(.parent(this),
                            .size(12),
                            .lsb_pos(20),
                            .access("RW"),
                            .volatile(0),
                            .reset(12'hfac),
                            .has_reset(1),
                            .is_rand(1),
                            .individually_accessible(1));
    endfunction :build
endclass :timer_1