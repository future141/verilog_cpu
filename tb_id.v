`include "pc_reg.v"
`include "if_id.v"
`include "id.v"
`include "regfile.v"

module tb();
    reg  clk,rst;
    reg  [`InstBus]     if_inst;
    // PC
    wire [`InstAddrBus] pc;
    wire ce;
    // IF ID
	wire [`InstAddrBus] id_pc_i;
	wire [`InstBus]     id_inst_i;
    // regfile
    wire reg1_read;
    wire reg2_read;
    wire[`RegBus] reg1_data;
    wire[`RegBus] reg2_data;
    wire[`RegAddrBus] reg1_addr;
    wire[`RegAddrBus] reg2_addr;
    
	wire wb_wreg_i;
	wire[`RegAddrBus] wb_wd_i;
	wire[`RegBus] wb_wdata_i;
    // ID
    wire[`AluOpBus] id_aluop_o;
	wire[`AluSelBus] id_alusel_o;
	wire[`RegBus] id_reg1_o;
	wire[`RegBus] id_reg2_o;
	wire id_wreg_o;
	wire[`RegAddrBus] id_wd_o;

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

        .id_pc(id_pc_i),
        .id_inst(id_inst_i)  
    );

    id id(
        .rst(rst),
        .pc_i(id_pc_i),
        .inst_i(id_inst_i),

        .reg1_data_i(reg1_data),
        .reg2_data_i(reg2_data),
        .reg1_read_o(reg1_read),
        .reg2_read_o(reg2_read),
        .reg1_addr_o(reg1_addr),
        .reg2_addr_o(reg2_addr), 
        
        .aluop_o(id_aluop_o),
        .alusel_o(id_alusel_o),
        .reg1_o(id_reg1_o),
        .reg2_o(id_reg2_o),
        .wd_o(id_wd_o),
        .wreg_o(id_wreg_o)
    );

	regfile regfile1(
		.clk (clk),
		.rst (rst),

		.we	(wb_wreg_i),
		.waddr (wb_wd_i),
		.wdata (wb_wdata_i),

		.re1 (reg1_read),
		.raddr1 (reg1_addr),
		.rdata1 (reg1_data),

		.re2 (reg2_read),
		.raddr2 (reg2_addr),
		.rdata2 (reg2_data)
	);

endmodule
