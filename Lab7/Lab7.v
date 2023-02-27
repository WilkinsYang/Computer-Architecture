module lab7(X,Y,z,clk,reset);
input [15:0]X;
input [15:0]Y;
reg [15:0]x;
reg [15:0]y;
reg [4:0]i;
output reg [47:0]z;
reg [11:0]Z;
input clk,reset;
reg [9:0]x1,x2,x3,x4,y1,y2,y3,y4,y5,y6,y7;
reg rx11,rx12,rx13,rx14,rx15,rx16,rx17;
reg rx21,rx22,rx23,rx24,rx25,rx26,rx27;
reg rx31,rx32,rx33,rx34,rx35,rx36,rx37;
reg rx41,rx42,rx43,rx44,rx45,rx46,rx47;

reg ry11,ry12,ry13,ry14,ry15,ry16,ry17;
reg ry21,ry22,ry23,ry24,ry25,ry26,ry27;
reg ry31,ry32,ry33,ry34,ry35,ry36,ry37;
reg ry41,ry42,ry43,ry44,ry45,ry46,ry47;

reg [2:0]o_z47,o_z37,o_z27,o_z17;
reg [2:0]o_z46,o_z36,o_z26,o_z16;
reg [2:0]o_z45,o_z35,o_z25,o_z15;
reg [2:0]o_z44,o_z34,o_z24,o_z14;
reg [2:0]o_z43,o_z33,o_z23,o_z13;
reg [2:0]o_z42,o_z32,o_z22,o_z12;

reg [2:0]z11,z12,z13,z14,z15,z16,z17;
reg [2:0]z21,z22,z23,z24,z25,z26,z27;
reg [2:0]z31,z32,z33,z34,z35,z36,z37;
reg [2:0]z41,z42,z43,z44,z45,z46,z47;

task c;
input x,y;
input [2:0]z;
output reg xx,yy;
output [2:0]zz;

	xx = x;
	yy = y;
	zz = z + (x*y);
endtask

always@(posedge clk)
begin
	if(reset)
	begin
		x <= X;
		y <= Y;
		i <= 0;
		z<=0;
		x1 <= {1'b0,1'b0,1'b0,x[3],1'b0,x[2],1'b0,x[1],1'b0,x[0]};
		x2 <= {1'b0,1'b0,x[7],1'b0,x[6],1'b0,x[5],1'b0,x[4],1'b0};
		x3 <= {1'b0,x[11],1'b0,x[10],1'b0,x[9],1'b0,x[8],1'b0,1'b0};
		x4 <= {x[15],1'b0,x[14],1'b0,x[13],1'b0,x[12],1'b0,1'b0,1'b0};
		y1 <= {1'b0,1'b0,1'b0,y[12],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
		y2 <= {1'b0,1'b0,y[13],1'b0,y[8],1'b0,1'b0,1'b0,1'b0,1'b0};
		y3 <= {1'b0,y[14],1'b0,y[9],1'b0,y[4],1'b0,1'b0,1'b0,1'b0};
		y4 <= {y[15],1'b0,y[10],1'b0,y[5],1'b0,y[0],1'b0,1'b0,1'b0};
		y5 <= {1'b0,y[11],1'b0,y[6],1'b0,y[1],1'b0,1'b0,1'b0,1'b0};
		y6 <= {1'b0,1'b0,y[7],1'b0,y[2],1'b0,1'b0,1'b0,1'b0,1'b0};
		y7 <= {1'b0,1'b0,1'b0,y[3],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
	end
	
	else
	begin
		c(rx46,ry37,0,rx47,ry47,z47);			//cell c4,7
		c(rx36,ry27,0,rx37,ry37,z37);			//cell c3,7
		c(rx26,ry17,0,rx27,ry27,z27);			//cell c2,7
		c(rx16,y7[0],0,rx17,ry17,z17);			//cell c1,7
		
		c(rx45,ry36,o_z47,rx46,ry46,z46);		//cell c4,6
		c(rx35,ry26,o_z37,rx36,ry36,z36);		//cell c3,6
		c(rx25,ry16,o_z27,rx26,ry26,z26);		//cell c2,6
		c(rx15,y6[0],o_z17,rx16,ry16,z16);		//cell c1,6
		o_z47=z47;
		o_z37=z37;
		o_z27=z27;
		o_z17=z17;
		
		
		c(rx44,ry35,o_z46,rx45,ry45,z45);		//cell c4,5
		c(rx34,ry25,o_z36,rx35,ry35,z35);		//cell c3,5
		c(rx24,ry15,o_z26,rx25,ry25,z25);		//cell c2,5
		c(rx14,y5[0],o_z16,rx15,ry15,z15);		//cell c1,5
		o_z46=z46;
		o_z36=z36;
		o_z26=z26;
		o_z16=z16;
		
		c(rx43,ry34,o_z45,rx44,ry44,z44);		//cell c4,4
		c(rx33,ry24,o_z35,rx34,ry34,z34);		//cell c3,4
		c(rx23,ry14,o_z25,rx24,ry24,z24);		//cell c2,4
		c(rx13,y4[0],o_z15,rx14,ry14,z14);		//cell c1,4
		o_z45=z45;
		o_z35=z35;
		o_z25=z25;
		o_z15=z15;
		
		
		c(rx42,ry33,o_z44,rx43,ry43,z43);		//cell c4,3
		c(rx32,ry23,o_z34,rx33,ry33,z33);		//cell c3,3
		c(rx22,ry13,o_z24,rx23,ry23,z23);		//cell c2,3
		c(rx12,y3[0],o_z14,rx13,ry13,z13);		//cell c1,3
		o_z44=z44;
		o_z34=z34;
		o_z24=z24;
		o_z14=z14;
		
		c(rx41,ry32,o_z43,rx42,ry42,z42);		//cell c4,2
		c(rx31,ry22,o_z33,rx32,ry32,z32);		//cell c3,2
		c(rx21,ry12,o_z23,rx22,ry22,z22);		//cell c2,2
		c(rx11,y2[0],o_z13,rx12,ry12,z12);		//cell c1,2
		o_z43=z43;
		o_z33=z33;
		o_z23=z23;
		o_z13=z13;
		
		c(x4[0],ry31,o_z42,rx41,ry41,z41);		//cell c4,1
		c(x3[0],ry21,o_z32,rx31,ry31,z31);		//cell c3,1
		c(x2[0],ry11,o_z22,rx21,ry21,z21);		//cell c2,1
		c(x1[0],y1[0],o_z12,rx11,ry11,z11);		//cell c1,1
		o_z42=z42;
		o_z32=z32;
		o_z22=z22;
		o_z12=z12;
		
		
		x1 <= x1>>1;
		x2 <= x2>>1;
		x3 <= x3>>1;
		x4 <= x4>>1;
		y1 <= y1>>1;
		y2 <= y2>>1;
		y3 <= y3>>1;
		y4 <= y4>>1;
		y5 <= y5>>1;
		y6 <= y6>>1;
		y7 <= y7>>1;
		Z <= {z11,z21,z31,z41};
		
		if(i<18)
		begin
			case(i+1)
				
				5'd8 :z[2:0] = Z[11:9];
				5'd9 :z[14:12] = Z[8:6];
				5'd10:begin	z[5:3] = Z[11:9]; z[26:24] = Z[5:3];	end
				5'd11:begin	z[17:15] = Z[8:6]; z[38:36] = Z[2:0];	end
				5'd12:begin	z[8:6] = Z[11:9]; z[29:27] = Z[5:3];	end
				5'd13:begin	z[20:18] = Z[8:6]; z[41:39] = Z[2:0];	end
				5'd14:begin	z[11:9] = Z[11:9]; z[32:30] = Z[5:3];	end
				5'd15:begin	z[23:21] = Z[8:6]; z[44:42] = Z[2:0];	end
				5'd16:z[35:33] = Z[5:3];
				5'd17:z[47:45] = Z[2:0];
				
			endcase
			
		end
		i = i + 1;
		
	end

end

endmodule

