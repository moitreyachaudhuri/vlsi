module vending_machine(i,j,clk,rst,x,y);
input i,j,clk,rst;
output reg x,y;
parameter s0=2'b00,s1=2'b01,s2=2'b10;
reg [1:0] ps,ns;
always@(posedge clk,posedge rst)
begin
if (rst)
	ps<=s0;
else
	ps<=ns;
end
always @(i,j,ps)
begin
ns=s0;
case(ps)
s0: ns=i?(j?s2:s1):s0;
s1: ns=i?(j?s0:s2):s1;
s2: ns= i?s0:s2;
endcase
end
always@(posedge clk,posedge rst)
begin
if (rst)
{x,y}<=2'b0;
else
begin
case(ps)
s0: {x,y}<=2'b0;
s1: {x,y}<=i?(j?2'b10:2'b00):2'b00;
s2: {x,y}<=i?(j?2'b11:2'b10):2'b00;
endcase
end
end
endmodule