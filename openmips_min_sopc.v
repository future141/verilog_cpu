`include "openmips.v"
`include "inst_rom.v"

module openmips_min_sopc(

	input wire  clk,
	input wire  rst
	
);

    wire[`InstAddrBus] inst_addr;
    wire[`InstBus] inst;
    wire rom_ce;

    openmips openmips(
        .clk(clk),
        .rst(rst),

        .rom_addr_o(inst_addr),
        .rom_data_i(inst),
        .rom_ce_o(rom_ce)
    );

	inst_rom inst_rom(
		.addr(inst_addr),
		.inst(inst),
		.ce(rom_ce)	
	);


endmodule