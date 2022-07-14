module test(
	
);
    reg[31:0]  inst_mem[0:131070];

    initial begin
        inst_mem[0] = 32'h34011100;
        inst_mem[1] = 32'h34011100;

        #50 $display(inst_mem[0],inst_mem[1]);
        #1000 $finish;
    end


endmodule