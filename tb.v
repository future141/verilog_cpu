`include "pc_reg.v"
`include "if_id.v"

module tb();
    reg  clk,rst;
    reg  [`InstBus]     if_inst;
    wire [`InstAddrBus] pc;
    wire ce;
    wire [`InstAddrBus] id_pc;
	wire [`InstBus]     id_inst;
    
    initial begin
        #0 clk = 0; rst = 1; if_inst = 32'h00000002;
        #100 rst = 0;
        #1000 $finish;
    end
    always begin
        #5 clk = ~clk;
    end
    pc_reg pc_reg(
        .clk(clk),
        .rst(rst),

        .pc(pc),
        .ce(ce)
    );

    if_id if_id(
        .clk(clk),
        .rst(rst),
        .if_pc(pc),
        .if_inst(if_inst),

        .id_pc(id_pc),
        .id_inst(id_pc)  
    );
endmodule