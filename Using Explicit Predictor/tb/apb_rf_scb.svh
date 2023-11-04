class apb_rf_scb extends uvm_scoreboard;
    `uvm_component_utils(apb_rf_scb)

    uvm_analysis_imp #(rf_sequence_item, apb_rf_scb) scb_imp;
    
    bit [SIZE-1:0] ctl_temp, stat_temp, to_temp,  t1_temp;

    function new(string name = "apb_rf_scb", uvm_component parent);
        super.new(name, parent);
        scb_imp = new("scb_imp", this);
    endfunction :new

    function void write(rf_sequence_item  item);
        `uvm_info(get_type_name(), $sformatf("data rcvd from mon_port, wr_enb =%0d, addr =%0d, din =%0h, dout =%0h",
                                              item.pwrite, item.paddr, item.pwdata, item.prdata), UVM_NONE)

        if (item.psel & item.penable & item.pwrite) begin
            case (item.paddr)
                'h0: begin
                    ctl_temp  = {'h0, item.pwdata[3:0]};
                    `uvm_info(get_type_name(), $sformatf("input data is stored in ctl %0h", item.pwdata) ,UVM_NONE)
                end
                'h4: begin
                    to_temp   = item.pwdata;
                    `uvm_info(get_type_name(), $sformatf("input data is stored in to %0h", item.pwdata) ,UVM_NONE)
                end
                'h8: begin
                    t1_temp   = item.pwdata;
                    `uvm_info(get_type_name(), $sformatf("input data is stored in t1 %0h", item.pwdata) ,UVM_NONE)
                end
                'hc: begin
                    stat_temp = {'h0, item.pwdata[1:0]};
                    `uvm_info(get_type_name(), $sformatf("input data is stored in stat %0h", item.pwdata) ,UVM_NONE)
                end
            endcase
        end
        else if (item.psel & !item.pwrite)  begin
            case (item.paddr)
                'h0: begin
                    if(item.prdata == ctl_temp)
                        `uvm_info("PASSED", "==== TEST IS PASSED ====", UVM_NONE)
                    else
                        `uvm_error("FAILED", "==== TEST IS FAILED ====")
                end
                'h4: begin
                    if(item.prdata == to_temp)
                        `uvm_info("PASSED", "==== TEST IS PASSED ====", UVM_NONE)
                    else
                        `uvm_error("FAILED", "==== TEST IS FAILED ====")
                end
                'h8: begin
                    if(item.prdata == t1_temp)
                        `uvm_info("PASSED", "==== TEST IS PASSED ====", UVM_NONE)
                    else
                        `uvm_error("FAILED", "==== TEST IS FAILED ====")
                end
                'hc: begin
                    if(item.prdata == stat_temp)
                        `uvm_info("PASSED", "==== TEST IS PASSED ====", UVM_NONE)
                    else
                        `uvm_error("FAILED", "==== TEST IS FAILED ====")
                end
            endcase
            `uvm_info(get_type_name(), $sformatf("output data is %0h", item.prdata) ,UVM_NONE)
        end
    endfunction :write
endclass :apb_rf_scb