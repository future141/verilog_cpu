`include "defines.v"
module inst_rom(

	input wire					ce,
	input wire[`InstAddrBus]	addr,
	output reg[`InstBus]		inst
	
);

	reg[`InstBus]  inst_mem[0:`InstMemNum-1];

	initial begin
        inst_mem[0] = 32'h34011100;
        inst_mem[1] = 32'h34020020;
		inst_mem[2] = 32'h3403ff00;
        inst_mem[3] = 32'h3404ffff;
        inst_mem[4] = 32'h3404ff00;
		// inst_mem[0] = 32'h34011100
		// $readmemh("./inst_rom.data", inst_mem);
		// $display(inst_mem);
	end

	always @ (*) begin
		if (ce == `ChipDisable) begin
			inst <= `ZeroWord;
		end 
		else begin
			// [`InstMemNumLog2+1:2] is equvalent to devided by 4
			inst <= inst_mem[addr[`InstMemNumLog2+1:2]];
		end
	end
	always begin
		#20 $display("0b%h",[addr[`InstMemNumLog2+1:2]]);
	end
endmodule