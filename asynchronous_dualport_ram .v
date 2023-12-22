module asynchronous_dualport_ram(rd_clk,wr_clk,rst,data_in,read_add,write_add,read,write,data_out);
input rd_clk,wr_clk,rst,read,write;
parameter ram_width=16;
parameter ram_depth=8;
parameter add_size=3;
input [add_size-1:0] read_add,write_add;
input [ram_width-1:0] data_in;
output reg [ram_width-1:0] data_out;
integer i;
reg [ram_width-1:0] mem [ram_depth-1:0];
always@(posedge wr_clk or posedge rst)
	begin
		if (rst)
			begin
				for (i=0;i<ram_depth;i=i+1)
					mem[i]<=0;
			end
		else
			begin
				if (write)	
					mem[write_add]<=data_in;
			end
	end
always@(posedge rd_clk or posedge rst)
	begin
		if (rst)
			begin
				data_out<=0;
			end
		else
			begin
				if (read)	
					data_out<=mem[read_add];
			end
	end

endmodule

	
	
