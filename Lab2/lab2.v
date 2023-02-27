module lab2_1 (mHz, reset, rb, win, lose, out, sel);
input mHz, reset;
input [1:0]rb;
output reg win,lose;
output reg [6:0]out;
output reg sel;
wire [2:0]counter;
wire [1:0]rb_in;
wire kHz, i;
reg [2:0]dice1, dice2;
reg sum, sum2;
reg [1:0]c;
reg [1:0]count1, count2;
div divid(mHz, kHz);
debounce de1(reset, kHz, i);
counting co1(kHz, counter);
//sel_count se1(kHz, sel);
debounce de2(rb[0], kHz, rb_in[0]);
debounce de3(rb[1], kHz, rb_in[1]);
//game g1(kHz, reset, rb_in, counter, win, lose, out, sel);

//endmodule

/*module game(clk,reset,rb,counter,win,lose,out,sel);
input clk,reset,sel;
input [1:0]rb;
input [2:0]counter;
output reg [6:0]out;
output reg win,lose;
reg [2:0]dice1,dice2;
reg [3:0]sum,newsum;
reg c1,c2;
reg [1:0]count1,count2;*/

always@(posedge mHz)
begin
	if( sel == 1 )
		sel <= 0;
	else
		sel <= ( sel + 1 );
		
	if( ~i )
	begin
		sum <= 0;
		sum2 <= 0;
		c[0] <= 0;
		c[1] <= 0;
		count1 <= 2;
		count2 <= 2;
		lose <= 0;
		win <= 0;
	end
	
	else
	begin
		if( ~rb[0] )
		begin
			if( count1 == 2 )
			begin
				dice1 <= counter;
				count1 <= 1;
				sum <= ( sum + dice1 );
			end
			else
			begin
				if(count1 == 2)
					dice1 <= 0;
			end
		end
			
			
		if( ~rb[1] )
		begin
			if( count2 == 2 )
			begin
				dice2 <= counter;
				count2 <= 1;
				sum <= ( sum + dice2 );
			end
			else
			begin
				if( count2 == 2 )
				dice2 <= 0;
			end
		end
		
		if( ( sum == 7 || sum == 11 ) && count1 == 1 && count2 ==1 )
		begin
			win <= 1;
			count1 <= 0;
			count2 <= 0;
		end
		else if( ( sum == 2 || sum == 3 || sum == 12 ) && count1 == 1 && count2 == 1 )
		begin
			lose <= 1;
			count1 <= 0;
			count2 <= 0;
		end
		//show(dice1, dice2, sel, out);
		
		if( ~rb[0] )
		begin
			dice1 <= counter;
			sum2 <= ( sum2 + dice1 );
			c[0] <= 1;
		end
		
		if( ~rb[1] )
		begin
			dice2 <= counter;
			sum2 <= ( sum2 + dice2 );
			c[1] <= 1;
		end
		
		if( sum2 == sum && c[0] == 1 && c[1] == 1 )
		begin
			win <= 1;
			count1 <= 0;
			count2 <= 0;
		end
		
		else if( sum2 == 7 && c[0] == 1 && c[1] == 1 )
		begin
			lose <= 1;
			count1 <= 0;
			count2 <= 0;
		end
		
		else
		begin
			sum2 <= 0;
			c[0] <= 0;
			c[1] <= 0;
		end
		//show(dice1, dice2, sel, out);
	end
end

always@(sel)
	case(sel)
		1'b0:show(dice1, out);
		1'b1:show(dice2, out);
	endcase
		
	
task show;
	input [2:0]dice;
	output reg [6:0]out;
	case(dice)
		3'd1:out=7'b0110_000;
		3'd2:out=7'b1101_101;
		3'd3:out=7'b1111_001;
		3'd4:out=7'b0110_011;
		3'd5:out=7'b1011_011;
		3'd6:out=7'b1011_111;
	endcase
endtask
endmodule




module counting(in,counter);
input in;
output reg [2:0]counter;
always@(posedge in)
	if(counter==6)
		counter<=1;
	else
		counter<=counter+1;

endmodule


module div(in,out);
input in;
output reg out;
reg [14:0]counter;
always@(posedge in)
if(counter==24999)
	begin
		counter<=0;
		out<=(~out);
	end
	
else
	counter<=counter+1;
endmodule

module debounce(in,kHz,out);
input in,kHz;
output out;
reg [6:0]d;

always@(posedge kHz)
	begin
		d<={d[5:0],in};
	end
and(out,d[6],d[5],d[4],d[3],d[2],d[1],d[0]);
endmodule

/*module sel_count (in,out);
input in;
output reg out;
reg count;

always@(posedge in)
begin
	if(count==1)
		begin
			out<=0;
			count<=0;
		end
	else
		begin
			out<=out+1;
			count<=count+1;
		end
end
endmodule*/
