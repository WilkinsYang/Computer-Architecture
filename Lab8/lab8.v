
module lab8(x,y,z,clk,reset);
input [3:0]x,y;			//x is multiplicand, y is multiplier
input clk,reset;
output reg [7:0]z;
reg [6:0]M0,M1,M2,M3;
reg count;
reg [6:0]carry1,carry2;
reg [6:0]sum1,sum2;


always@(posedge clk)
begin
	if(reset)
	begin
		M0<={1'b0,1'b0,1'b0,(x[3]&y[0]),(x[2]&y[0]),(x[1]&y[0]),(x[0]&y[0])};
		M1<={1'b0,1'b0,(x[3]&y[1]),(x[2]&y[1]),(x[1]&y[1]),(x[0]&y[1]),1'b0};
		M2<={1'b0,(x[3]&y[2]),(x[2]&y[2]),(x[1]&y[2]),(x[0]&y[2]),1'b0,1'b0};
		M3<={(x[3]&y[3]),(x[2]&y[3]),(x[1]&y[3]),(x[0]&y[3]),1'b0,1'b0,1'b0};
		carry1<=0;
		sum1<=0;
		carry2<=0;
		sum2<=0;
		z<=0;
		count<=0;
	end
	
	else
	begin
		if(count ==0)
		begin
		fulladder(M0[0],M1[0],M2[0],carry1[0],sum1[0]);
		fulladder(M0[1],M1[1],M2[1],carry1[1],sum1[1]);
		fulladder(M0[2],M1[2],M2[2],carry1[2],sum1[2]);
		fulladder(M0[3],M1[3],M2[3],carry1[3],sum1[3]);
		fulladder(M0[4],M1[4],M2[4],carry1[4],sum1[4]);
		fulladder(M0[5],M1[5],M2[5],carry1[5],sum1[5]);
		fulladder(M0[6],M1[6],M2[6],carry1[6],sum1[6]);
		carry1 = carry1<<1;
		count<=1;
		end
		
		else if(count ==1)
		begin
		fulladder(carry1[0],sum1[0],M3[0],carry2[0],sum2[0]);
		fulladder(carry1[1],sum1[1],M3[1],carry2[1],sum2[1]);
		fulladder(carry1[2],sum1[2],M3[2],carry2[2],sum2[2]);
		fulladder(carry1[3],sum1[3],M3[3],carry2[3],sum2[3]);
		fulladder(carry1[4],sum1[4],M3[4],carry2[4],sum2[4]);
		fulladder(carry1[5],sum1[5],M3[5],carry2[5],sum2[5]);
		fulladder(carry1[6],sum1[6],M3[6],carry2[6],sum2[6]);
		carry2 = carry2<<1;
		z = sum2 + carry2;
		count<=0;
		end
	end
end



task fulladder;
input x,y,z;
output reg c,s;
 {c,s} = x + y + z;
endtask

endmodule



