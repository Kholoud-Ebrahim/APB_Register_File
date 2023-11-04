class reg_seq_write_t1 extends uvm_sequence;
    `uvm_object_utils(reg_seq_write_t1)

    reg_block  reg_blk_h;

    function new(string name = "reg_seq_write_t1");
        super.new(name);
    endfunction :new

    task body();
        uvm_status_e  status;
        bit[SIZE-1:0] rand_val;

        `uvm_info("Initial timer_1 reg", $sformatf("timer_1_reg = %0h\ntimer_y2r = %0h\ntimer_r2g = %0h\ntimer_g2y = %0h\n", 
                    reg_blk_h.timer_1_h.get_reset(),
                    reg_blk_h.timer_1_h.timer_y2r.get_reset(),
                    reg_blk_h.timer_1_h.timer_r2g.get_reset(),
                    reg_blk_h.timer_1_h.timer_g2y.get_reset()), UVM_NONE);
                    
        std::randomize(rand_val) with {rand_val dist {[0:SIZE/2-1]:/50, [SIZE/2:SIZE-1]:/30};};
        reg_blk_h.timer_1_h.write(status, rand_val, UVM_FRONTDOOR);
        `uvm_info("After Write ctl reg", $sformatf("timer_1_reg = %0h\ntimer_y2r = %0h\ntimer_r2g = %0h\ntimer_g2y = %0h\n",
                    reg_blk_h.timer_1_h.get(),
                    reg_blk_h.timer_1_h.timer_y2r.get(),
                    reg_blk_h.timer_1_h.timer_r2g.get(),
                    reg_blk_h.timer_1_h.timer_g2y.get()), UVM_NONE);

    endtask :body
endclass :reg_seq_write_t1