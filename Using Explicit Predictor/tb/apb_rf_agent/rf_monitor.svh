class rf_monitor extends uvm_monitor;
    `uvm_component_utils(rf_monitor)

    rf_sequence_item  item;
    virtual apb_rf_intf #(SIZE) mon_vif;
    uvm_analysis_port #(rf_sequence_item) mon_port;

    function new(string name = "rf_monitor", uvm_component parent);
        super.new(name, parent);
        mon_port = new("mon_port", this);
    endfunction :new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        item = rf_sequence_item::type_id::create("item");
        if(! uvm_config_db #(virtual apb_rf_intf #(SIZE))::get(this, "", "vif", mon_vif))
            `uvm_fatal(get_full_name(), "Can't get vif in monitor from config_db")
    endfunction :build_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            wait(mon_vif.presetn);

            @(posedge mon_vif.pclk);
            #(PERIOD/4.0);
            if(mon_vif.pwrite) begin  // write
                item.paddr   = mon_vif.paddr;
                item.pwdata  = mon_vif.pwdata;
                item.psel    = mon_vif.psel;
                item.pwrite  = mon_vif.pwrite;
                item.penable = mon_vif.penable;
                item.prdata  = mon_vif.prdata;
                @(posedge mon_vif.pclk);
                #(PERIOD/4.0);
            end
            else begin  // read
                item.paddr   = mon_vif.paddr;
                item.pwdata  = mon_vif.pwdata;
                item.psel    = mon_vif.psel;
                item.pwrite  = mon_vif.pwrite;
                item.penable = mon_vif.penable;
                item.prdata  = mon_vif.prdata;
                @(posedge mon_vif.pclk);
                #(PERIOD/4.0);
            end
            mon_port.write(item);
        end
    endtask :run_phase
endclass :rf_monitor