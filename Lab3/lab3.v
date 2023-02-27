module lab3(x,z,clk,reset);
input [3:0]x;
input clk,reset;
reg [1:0]d;
reg [2:0]sum;
output reg z;

always@(posedge clk)
begin
	if(reset)
		begin
			d=2'd0;
		end
	sum=x[0]+x[1]+x[2]+x[3]+d;
	d[1]=sum[2];
	d[0]=sum[1];
	z=sum[0];

end

endmodule

