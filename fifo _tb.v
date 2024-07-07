module fifo_tb();
reg clk,rst,re,we;
reg [7:0] data_in;
wire empty,full;
wire [7:0] data_out;
fifo dut(clk,rst,re,we,data_in,empty,full,data_out );
task initialise();
begin
clk=1'b0;
rst=1'b0;
re=1'b0;
we=1'b0;
data_in=8'b0;
end
endtask
always #10 clk=~clk;
task rst_dut();
begin
	@(negedge clk)
		rst=1'b1;
	@(negedge clk)
		rst=1'b0;
end
endtask
task write_fifo(input [7:0]a);
begin
@(negedge clk);
we=1'b1;
data_in=a;
end
endtask
task read_fifo();
begin
@(negedge clk)
re=1'b1;
end
endtask
initial
begin
initialise();
#50;
repeat(17)
write_fifo({$random}%8);
we=1'b0;
repeat(17)
read_fifo();
re=1'b0;
#100
$finish;
end
endmodule
