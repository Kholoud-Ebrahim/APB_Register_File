class reg_seq_write_ctl extends uvm_sequence;
    `uvm_object_utils(reg_seq_write_ctl)

    reg_block  reg_blk_h;

    function new(string name = "reg_seq_write_ctl");
        super.new(name);
    endfunction :new

    task body();
        uvm_status_e  status;
        bit[SIZE-1:0] rand_val;
                  
        std::randomize(rand_val) with {rand_val dist {[0:5]:/50, [6:13]:/50};};
        reg_blk_h.ctl_reg_h.write(status, rand_val, UVM_FRONTDOOR);
        `uvm_info("After Write ctl reg", $sformatf("ctl_reg = %0h\nen = %0h\nbl_y = %0h\nbl_r = %0h\nprofile = %0h\n", 
                    reg_blk_h.ctl_reg_h.get(),
                    reg_blk_h.ctl_reg_h.en.get(),
                    reg_blk_h.ctl_reg_h.bl_y.get(),
                    reg_blk_h.ctl_reg_h.bl_r.get(),
                    reg_blk_h.ctl_reg_h.profile.get()), UVM_NONE);

    endtask :body
endclass :reg_seq_write_ctl