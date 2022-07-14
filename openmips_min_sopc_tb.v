`include "defines.v"
`include "openmips_min_sopc.v"

module openmips_min_sopc_tb();

    reg     CLOCK_50;
    reg     rst;


    initial begin
        CLOCK_50 = 1'b0;
        forever #10 CLOCK_50 = ~CLOCK_50;
    end

    initial begin
        rst = `RstEnable;
        #195 rst= `RstDisable;
        #2000 $finish;
    end

    openmips_min_sopc openmips_min_sopc(
        .clk(CLOCK_50),
        .rst(rst)	
    );


endmodule