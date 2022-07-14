`include "defines.v"
`include "openmips_min_sopc.v"

module openmips_min_sopc_tb();

    reg     clk;
    reg     rst;


    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end

    initial begin
        rst = `RstEnable;
        #50 rst= `RstDisable;
        #110 $finish;
    end

    openmips_min_sopc openmips_min_sopc(
        .clk(clk),
        .rst(rst)	
    );


endmodule