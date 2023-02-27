module lab9(x,y,z,clk,reset);
input [7:0]x,y;
input clk,reset;
output reg [7:0]z;
reg [7:0]xr,yr,tmp;


always@(posedge clk)
begin
	if(reset)
	begin
		xr<=x;
		yr<=y;
		z<=0; 
	end
	
	else 
	begin
		if(xr>0)
		begin
			if(xr<=yr)
			begin
				tmp=xr;
				xr = yr;
				yr=tmp;
			end
			xr = xr - yr;
		
		
			
		end
		
		else
		begin
			z=yr;
		end
	end
	
end


endmodule




