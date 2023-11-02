class apb_adapter extends uvm_reg_adapter;
    `uvm_object_utils(apb_adapter)

    function new(string name = "apb_adapter");
        super.new(name);
    endfunction :new

    function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        rf_sequence_item  item = rf_sequence_item::type_id::create("item");

        item.pwrite = (rw.kind == UVM_WRITE)? 1:0;
        item.paddr  = rw.addr;
        if(item.pwrite)
            item.pwdata = rw.data;

        return item;
    endfunction :reg2bus

    function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        rf_sequence_item  item;

        assert($cast(item, bus_item));
        rw.kind   = (item.pwrite)? UVM_WRITE : UVM_READ;
        rw.data   = (item.pwrite)? item.pwdata : item.prdata;
        rw.addr   = item.paddr;
        rw.status = UVM_IS_OK;
        
    endfunction :bus2reg
endclass :apb_adapter