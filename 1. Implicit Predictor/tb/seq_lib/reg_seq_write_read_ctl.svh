class reg_seq_write_read_ctl extends uvm_sequence;
    `uvm_object_utils(reg_seq_write_read_ctl)

    reg_block  reg_blk_h;

    function new(string name = "reg_seq_write_read_ctl");
        super.new(name);
    endfunction :new

    task body();
        uvm_status_e  status;
        bit[SIZE-1:0] read_out, rand_val;

        `uvm_info("Initial ctl reg", $sformatf("ctl_reg = %0h\nen = %0h\nbl_y = %0h\nbl_r = %0h\nprofile = %0h\n", 
                    reg_blk_h.ctl_reg_h.get_reset(),
                    reg_blk_h.ctl_reg_h.en.get_reset(),
                    reg_blk_h.ctl_reg_h.bl_y.get_reset(),
                    reg_blk_h.ctl_reg_h.bl_r.get_reset(),
                    reg_blk_h.ctl_reg_h.profile.get_reset()), UVM_NONE);
                    
        std::randomize(rand_val) with {rand_val dist {[0:SIZE/2-1]:/50, [SIZE/2:SIZE-1]:/30};};
        reg_blk_h.ctl_reg_h.write(status, rand_val, UVM_FRONTDOOR);
        `uvm_info("After Write ctl reg", $sformatf("ctl_reg = %0h\nen = %0h\nbl_y = %0h\nbl_r = %0h\nprofile = %0h\n", 
                    reg_blk_h.ctl_reg_h.get(),
                    reg_blk_h.ctl_reg_h.en.get(),
                    reg_blk_h.ctl_reg_h.bl_y.get(),
                    reg_blk_h.ctl_reg_h.bl_r.get(),
                    reg_blk_h.ctl_reg_h.profile.get()), UVM_NONE);

        reg_blk_h.ctl_reg_h.read(status, read_out, UVM_FRONTDOOR);
        `uvm_info("After read ctl reg", $sformatf("ctl_reg = %0h\nen = %0h\nbl_y = %0h\nbl_r = %0h\nprofile = %0h\nread_out = %0h", 
                    reg_blk_h.ctl_reg_h.get(),
                    reg_blk_h.ctl_reg_h.en.get(),
                    reg_blk_h.ctl_reg_h.bl_y.get(),
                    reg_blk_h.ctl_reg_h.bl_r.get(),
                    reg_blk_h.ctl_reg_h.profile.get(), read_out), UVM_NONE);
    endtask :body
endclass :reg_seq_write_read_ctl