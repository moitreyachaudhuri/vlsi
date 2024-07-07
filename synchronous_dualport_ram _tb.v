module dualportram_tb();
reg clk,rst,read,write;
parameter ram_width=8;
parameter ram_depth=16;
parameter add_size=4;
parameter cycle=10;
reg [add_size-1:0] read_add,write_add;
reg [ram_width-1:0] data_in;
wire [ram_width-1:0] data_out;
integer i;
synchronous_dualport_ram dut(clk,rst,data_in,read_add,write_add,read,write,data_out);
initial
begin
rst=0;
read=0;
write=0;

end
always
	begin
		#(cycle/2);
		clk=1'b0;
		#(cycle/2);
		clk=1'b1;
	end
task rst_dut();
	begin
		@(negedge clk);
		rst=1'b1;
		@(negedge clk);
		rst=1'b0;
	end
endtask
task write_t(input [7:0]a,input [3:0]b,input w,r);
	begin
	@(negedge clk)
		write=w;
		read=r;
		write_add=b;
		data_in=a;
	end
endtask
task read_t(input [3:0]b,input r,w);
	begin
	@(negedge clk)
		write=w;
		read=r;
		read_add=b;
	end
endtask

		
initial
begin
rst_dut();
repeat(10)
	write_t({$random}%256,{$random}%16,1'b1,1'b0);
repeat(10)
	read_t({$random}%16,1'b1,1'b0);


#100 $finish;
end
endmodule
		
	
	
	
	
	

	
	
