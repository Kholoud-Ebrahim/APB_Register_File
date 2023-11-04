package reg_model_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import param_pkg::*;

    import seq_item_pkg::*;

    `include "ctl_reg.svh"
    `include "stat_reg.svh"
    `include "timer_0.svh"
    `include "timer_1.svh"
    `include "reg_block.svh"
    `include "apb_adapter.svh"

endpackage :reg_model_pkg