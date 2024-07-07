module fifo(input clk,rst,re,we,input [7:0] data_in,output empty,full,output reg [7:0] data_out );
reg [3:0] rd_ptr=1'b0;
reg [3:0] wr_ptr=1'b0;
reg [4:0] fifo_counter;
reg [7:0] mem [15:0];
integer i;
assign full=(fifo_counter > 5'b01111);
assign empty=(fifo_counter==5'b0);
always@(posedge clk)
begin
	if (rst)
		fifo_counter<=0;
	else if(!full&&we)
		fifo_counter<=fifo_counter+1;
	else if(!empty&&re)
		fifo_counter<=fifo_counter-1;
	else
		fifo_counter<=fifo_counter;
end
always@(posedge clk)
begin
	if (rst)
		begin
			for (i=0;i<16;i=i+1)
				mem[i]<=0;
				wr_ptr<=0;
		end
	else if(!full&&we)
		begin
			mem[wr_ptr]<=data_in;
			wr_ptr<=wr_ptr+1;
		end
	else
		wr_ptr<=wr_ptr;
end
always@(posedge clk)
begin
	if (rst)
		begin
			rd_ptr<=0;
			data_out<=8'b0;
		end
	else if(!empty&&re)
		begin
			data_out<=mem[rd_ptr];
			rd_ptr<=rd_ptr+1;
		end
	else
		rd_ptr<=rd_ptr;
end
endmodule


	
		

	
	
	
	
	

	
	
