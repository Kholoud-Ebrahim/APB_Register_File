interface apb_rf_intf #(parameter SIZE = 32) (input pclk, presetn);
    logic [SIZE-1:0]   paddr;
    logic [SIZE-1:0]   pwdata;
    logic              psel;
    logic              pwrite;
    logic              penable;
    logic [SIZE-1:0]   prdata;
endinterface :apb_rf_intf