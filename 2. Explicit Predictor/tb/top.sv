`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

import param_pkg::*;
import apb_rf_pkg::*;

module top; 
    bit clk, rst;
    apb_rf_intf #(SIZE)      intf (.pclk(clk), .presetn(rst));
    apb_register_file #(SIZE) dut (.pclk(clk), 
                                   .presetn(rst), 
                                   .paddr(intf.paddr), 
                                   .pwdata(intf.pwdata), 
                                   .psel(intf.psel), 
                                   .pwrite(intf.pwrite), 
                                   .penable(intf.penable), 
                                   .prdata(intf.prdata));

    initial begin
        uvm_config_db #(virtual apb_rf_intf #(SIZE))::set(null, "*", "vif", intf);
        run_test("");
    end
    initial begin
        clk = 1;
        forever
            #(PERIOD/2.0)  clk = ~clk;
    end
    initial begin
        rst = 0;
        #(PERIOD*3.0);
        rst = 1;
    end
endmodule :top