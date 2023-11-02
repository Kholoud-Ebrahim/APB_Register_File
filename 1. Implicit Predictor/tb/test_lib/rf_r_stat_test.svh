class rf_r_stat_test extends apb_rf_base_test;
    `uvm_component_utils(rf_r_stat_test)

    reg_seq_read_stat   seq_1;

    function new(string name = "rf_r_stat_test", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        seq_1 = reg_seq_read_stat::type_id::create("seq_1");

    endfunction :build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        seq_1.reg_blk_h = rf_env_h.reg_block_h;
        repeat(2) begin
            seq_1.start(rf_env_h.rf_agent_h.rf_sqr);
        end
        phase.drop_objection(this);
    endtask :run_phase
endclass :rf_r_stat_test