class rf_driver extends uvm_driver #(rf_sequence_item);
    `uvm_component_utils(rf_driver)

    virtual apb_rf_intf #(SIZE)  drv_vif;
    rf_sequence_item             drv_item;

    function new(string name = "rf_driver", uvm_component parent);
        super.new(name, parent);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(! uvm_config_db#(virtual apb_rf_intf #(SIZE))::get(this, "", "vif", drv_vif))
            `uvm_fatal(get_full_name(), "Can't get vif from uvm_config_db")
    endfunction :build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            seq_item_port.get_next_item(drv_item);
            drive(drv_item);
            seq_item_port.item_done();
        end
    endtask :run_phase

    task drive(rf_sequence_item item);
        if(! drv_vif.presetn) begin //active low reset
            drv_vif.paddr   <= 'h0;
            drv_vif.pwdata  <= 'h0;
            drv_vif.psel    <= 'h0;
            drv_vif.pwrite  <= 'h0;
            drv_vif.penable <= 'h0;
        end

        wait(drv_vif.presetn);

        @(posedge drv_vif.pclk);
        if(item.pwrite) begin // write
            drv_vif.paddr   <= item.paddr;
            drv_vif.pwdata  <= item.pwdata;
            drv_vif.pwrite  <= 1;
            drv_vif.psel    <= 1;
            drv_vif.penable <= 1;

            @(posedge drv_vif.pclk);
            drv_vif.psel    <= 0;
            drv_vif.penable <= 0;
        end
        else begin  // read
            drv_vif.paddr   <= item.paddr;
            drv_vif.pwrite  <= 0;
            drv_vif.psel    <= 1;
            drv_vif.penable <= 1;

            @(posedge drv_vif.pclk);
            item.prdata = drv_vif.prdata;
            drv_vif.psel    <= 0;
            drv_vif.penable <= 0;
        end
    endtask :drive
endclass :rf_driver