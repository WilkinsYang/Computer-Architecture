module lab1_1(reset,mHz,a,b,result);
 input [3:0]a,b;
 input reset,mHz;
 output reg [7:0]result;
 reg [3:0]b1;
 reg [7:0]a1;
 reg [7:0]s;
 reg [2:0]n = 4;
 wire clk,i;
 div d1(mHz,clk);
 debounce de1(clk,reset,i);
 
 always@(posedge mHz)
 begin
  if(~reset)
	begin
	if( n > 0 )
		begin
		if( b1[0] )
			begin
			s <= s + a1;
			end
		a1 <= ( a1 << 1 );
		b1 <= ( b1 >> 1 );
		n = n - 1;
		end
   
	else
		begin
		result[7:0] <= { s[7:0] };
		end
  end
  
  else
	  begin
		a1 <= 0;
		b1 <= b;
		s <= 0;
		a1[3:0] <= { a[3:0] };
		n = 4;
		result[7:0] <= { s[7:0] };
	  end
 end
 
endmodule


module div(in,out);
input in;
output reg out;
reg [14:0]counter;
always@(posedge in)
 if(counter==24999)
  begin
   counter<=0;
   out=~out;
  end
 else
  counter<=counter+1;
endmodule

module debounce(kHz, in, out);
input kHz,in;
output out;
reg [6:0]d;

always@(posedge kHz)
 begin
  d<={d[5:0],in};
 end
and(out,d[6],d[5],d[4],d[3],d[2],d[1],d[0]);
endmodule