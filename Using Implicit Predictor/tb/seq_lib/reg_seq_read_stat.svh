class reg_seq_read_stat extends uvm_sequence;
    `uvm_object_utils(reg_seq_read_stat)

    reg_block  reg_blk_h;

    function new(string name = "reg_seq_read_stat");
        super.new(name);
    endfunction :new

    task body();
        uvm_status_e  status;
        bit[SIZE-1:0] read_out;

        `uvm_info("Initial stat reg", $sformatf("stat_reg = %0h\nstat = %0h\n", 
                    reg_blk_h.stat_reg_h.get_reset(),
                    reg_blk_h.stat_reg_h.stat.get_reset()), UVM_NONE);
                    
       
        reg_blk_h.stat_reg_h.read(status, read_out, UVM_FRONTDOOR);
        `uvm_info("After read stat reg", $sformatf("stat_reg = %0h\nstat = %0h\n", 
                    reg_blk_h.stat_reg_h.get(),
                    reg_blk_h.stat_reg_h.stat.get(), read_out), UVM_NONE);
                    
    endtask :body
endclass :reg_seq_read_stat