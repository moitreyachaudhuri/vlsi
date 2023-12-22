module a(input re,we,inout [15:0] data,input[2:0]add);
reg [15:0] mem [7:0];
integer i;
always @(re,we,data,add)
begin
	if(we&&~re)
		mem[add]=data;
end
assign data=(re&&!we) ? mem[add]:16'bz;
endmodule

