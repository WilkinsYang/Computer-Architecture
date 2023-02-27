module lab6(multiplicand,multiplier,clk,reset,result);
input signed [7:0]multiplicand,multiplier;
input clk,reset;
reg [2:0]count;
output reg signed [15:0]result;
wire signed [15:0]x1,x2;
reg signed [15:0] out;
trans(multiplicand,reset,x1,x2);

always@(posedge clk or posedge reset)
begin
	if(reset)
		begin
			count<=0;
			result<=0;
			out<=0;
		end
		
	else
		begin
			if(0<count && count<7)
				begin
					case({multiplier[count],multiplier[count-1]})
						2'b01:begin  out = out + (x1<<<count);	count=count+1;	end
						2'b10:begin  out = out + (x2<<<count);	count=count+1;	end
						default:count=count+1;
					endcase
					
				end
				
			else if(count == 7)
				begin
					case({multiplier[count],multiplier[count-1]})
						2'b01:begin  out = out + (x1<<<count);	end
						2'b10:begin  out = out + (x2<<<count);	end
					endcase
					result = out;
					count = 0;
				end
				
			else if(count == 0)
				begin
					if(multiplier[0] == 1)
						begin
							out = x2;
							count=count+1;
						end
					else
						begin
						count=count+1;
						out = 0;
						end
				end
	

		end



end


endmodule


module trans(in,reset,out1,out2); //signed extansion to 16bits
input signed [7:0]in;
input reset;
output reg signed [15:0]out1,out2;

always@(*)
begin
	if(reset)
		begin
			out1<=0;
			out2<=0;
		end
	else
		begin
		out1<=in;
		out2<=-in;
		end

end

endmodule

