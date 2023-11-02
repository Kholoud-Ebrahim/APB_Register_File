package seq_lib_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import param_pkg::*;

    import reg_model_pkg::*;
    
    `include "reg_seq_write_read_ctl.svh"
    `include "reg_seq_write_ctl.svh"
    `include "reg_seq_read_ctl.svh"

    `include "reg_seq_read_stat.svh"

    `include "reg_seq_write_read_to.svh"
    `include "reg_seq_write_to.svh"
    `include "reg_seq_read_to.svh"

    `include "reg_seq_write_read_t1.svh"
    `include "reg_seq_write_t1.svh"
    `include "reg_seq_read_t1.svh"

endpackage :seq_lib_pkg