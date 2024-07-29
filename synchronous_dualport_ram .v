module synchronous_dualport_ram(clk,rst,data_in,read_add,write_add,read,write,data_out);
input clk,rst,read,write;
parameter ram_width=8;
parameter ram_depth=16;
parameter add_size=4;
input [add_size-1:0] read_add,write_add;
input [ram_width-1:0] data_in;
output reg [ram_width-1:0] data_out;
integer i;
reg [ram_width-1:0] mem [ram_depth-1:0];
always@(posedge clk)
	begin
		if (rst)
			begin
				data_out=0;
				for (i=0;i<ram_depth;i=i+1)
					mem[i]<=0;
			end
		else
			begin
				if (write)	
					mem[write_add]<=data_in;
				if (read)
				
					data_out<=mem[read_add];
			end
	end
endmodule

	
	
