class stat_reg extends uvm_reg;
    `uvm_object_utils(stat_reg)

    uvm_reg_field   stat;

    covergroup cov_stat;
        option.per_instance = 1;
        coverpoint stat.value[1:0] {
            bins stat_lo = {0, 1};
        }
    endgroup :cov_stat

    function new(string name = "stat_reg");
        super.new(name, 32, UVM_CVR_FIELD_VALS);

        if(has_coverage(UVM_CVR_FIELD_VALS)) begin
            cov_stat = new();
        end
    endfunction :new

    function void sample(uvm_reg_data_t data, uvm_reg_data_t byte_en, bit is_read, uvm_reg_map map);
        cov_stat.sample();
    endfunction :sample

    function void sample_values();
        super.sample_values();
        cov_stat.sample();
    endfunction :sample_values

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