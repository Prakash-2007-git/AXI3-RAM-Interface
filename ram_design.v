`timescale 1ns/1ps

module ram_design #(
    parameter addr_width = 4,
    parameter data_width = 32,
    parameter depth      = 16
)(
    input                    clk,
    input                    rst_n,
    input                    wr_enb,
    input  [addr_width-1:0]  addr,
    input  [data_width-1:0]  wdata,
    output reg [data_width-1:0] rdata
);

reg [data_width-1:0] mem [0:depth-1];

integer i;
initial begin
    for (i = 0; i < depth; i = i + 1)
        mem[i] = {data_width{1'b0}};
end

always @(posedge clk) begin
    if (!rst_n)
        rdata <= {data_width{1'b0}};
    else begin
        if (wr_enb)
            mem[addr] <= wdata;
        else
            rdata <= mem[addr];
    end
end

endmodule