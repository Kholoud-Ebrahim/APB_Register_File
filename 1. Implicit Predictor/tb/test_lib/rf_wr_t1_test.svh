class rf_wr_t1_test extends apb_rf_base_test;
    `uvm_component_utils(rf_wr_t1_test)

    reg_seq_write_read_t1   seq_1;
    reg_seq_write_t1        seq_2;
    reg_seq_read_t1         seq_3;

    function new(string name = "rf_wr_t1_test", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        seq_1 = reg_seq_write_read_t1::type_id::create("seq_1");
        seq_2 = reg_seq_write_t1::type_id::create("seq_2");
        seq_3 = reg_seq_read_t1::type_id::create("seq_3");

    endfunction :build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        seq_1.reg_blk_h = rf_env_h.reg_block_h;
        seq_2.reg_blk_h = rf_env_h.reg_block_h;
        seq_3.reg_blk_h = rf_env_h.reg_block_h;
        repeat(4) begin
            seq_1.start(rf_env_h.rf_agent_h.rf_sqr);
            seq_2.start(rf_env_h.rf_agent_h.rf_sqr);
            seq_3.start(rf_env_h.rf_agent_h.rf_sqr);
        end
        phase.drop_objection(this);
    endtask :run_phase
endclass :rf_wr_t1_test