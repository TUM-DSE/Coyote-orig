import lynxTypes::*;

module perf_host (
    input  logic            aclk,
    input  logic            aresetn,

    AXI4SR.s                 axis_in,
    AXI4SR.m                 axis_out
);

localparam integer N_INTS = AXI_DATA_BITS / 32;

always_comb begin
    axis_out.tvalid  = axis_in.tvalid;
    for(int i = 0; i < 16; i++)
        axis_out.tdata[i*32+:32] = axis_in.tdata[i*32+:32] + 1; 
    axis_out.tkeep   = axis_in.tkeep;
    axis_out.tid     = axis_in.tid;
    axis_out.tlast   = axis_in.tlast;
    
    axis_in.tready = axis_out.tready;
end

endmodule