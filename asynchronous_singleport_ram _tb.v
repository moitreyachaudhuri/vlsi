module asyncdualportram_tb();
reg rd_clk,wr_clk,rst,read,write;
parameter ram_width=16;
parameter ram_depth=8;
parameter add_size=3;
parameter cycle=10;
reg [add_size-1:0] read_add,write_add;
reg [ram_width-1:0] data_in;
wire [ram_width-1:0] data_out;
integer i,j;
asynchronous_dualport_ram dut(rd_clk,wr_clk,rst,data_in,read_add,write_add,read,write,data_out);
initial
begin
rst=0;
read=0;
write=0;
read_add=0;
write_add=0;
rd_clk=0;
wr_clk=0;
end
always #10 wr_clk=~wr_clk;
always #20 rd_clk=~rd_clk;
task rst_dut();
	begin
		rst=1'b1;
		#50
		rst=1'b0;
	end
endtask
task write_t(input [2:0]a,input [15:0]b);
	begin
	@(negedge wr_clk)
		write=1'b1;
		write_add=a;
		data_in=b;
	end
endtask
task read_t(input [2:0]c);
	begin
	@(negedge rd_clk)
		read=1'b1;
		read_add=c;
	end
endtask
initial
begin
#10
rst_dut();
for (i=0;i<8;i=i+1)
begin
	write_t(i,{$random}%16);
end
for (j=0;j<8;j=j+1)
begin
	read_t(j);
end
#100 $finish;
end
endmodule
		
	
	
	
	
	

	
	
