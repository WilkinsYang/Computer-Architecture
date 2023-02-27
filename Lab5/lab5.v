module lab5(write_select,Cin,enable,clk,reset,A_select,B_select,S,H_select,M_select,out,Cout);
input [1:0]write_select,A_select,B_select,H_select;
input clk,reset,enable,Cin,M_select;
input [2:0]S;
output [3:0]out;
output Cout;
wire [3:0]d_data;
wire [3:0]out_shift;
wire [3:0]out_reg1,out_reg2;
reg [3:0]choose;
wire [3:0]o1,o2;
assign d_data = out;

reg_file re1(write_select,clk,reset,enable,d_data,A_select,B_select,out_reg1,out_reg2);
function_unit f1(out_reg1,out_reg2,S,H_select,M_select,Cin,clk,out_shift,Cout,reset);
//ALU al1(out_reg1,out_reg2,S,Cin,clk,o1,Cout);
//shifter sh1(out_reg1,H_select,clk,o2);


assign out = out_shift;

endmodule



module reg_file(write_select,clk,reset,enable,d_data,A_select,B_select,out_reg1,out_reg2);
input [1:0]write_select,A_select,B_select;
input clk,reset,enable;
input [3:0]d_data;
output reg [3:0]out_reg1,out_reg2;
reg f;
reg [3:0]R0,R1,R2,R3;


always@(negedge clk/* f or reset or enable or A_select or B_select */)
begin
	/*if(~f)
	begin
		R0 = 4'b1010;
		R1 = 4'b0110;
		R2 = 4'b1001;
		R3 = 4'b1110;
		f = 1;
	end*/
	
	if(reset)
	begin
		R0 = 4'b0010;
		R1 = 4'b1010;
		R2 = 4'b1101;
		R3 = 4'b0111;
	end
	
	else
	begin
		if(enable)
		begin
			case(write_select)
				2'b00:R0 = d_data;
				2'b01:R1 = d_data;
				2'b10:R2 = d_data;
				2'b11:R3 = d_data;
			endcase
		end
		
		case(A_select)
			2'b00:out_reg1 = R0;
			2'b01:out_reg1 = R1;
			2'b10:out_reg1 = R2;
			2'b11:out_reg1 = R3;
		endcase
		
		case(B_select)
			2'b00:out_reg2 = R0;
			2'b01:out_reg2 = R1;
			2'b10:out_reg2 = R2;
			2'b11:out_reg2 = R3;
		endcase
	end

end
endmodule
////////
module function_unit(A,B,S,H_select,MF_select,Cin,clk,G,Cout,reset);
input [3:0]A,B;
input [2:0]S;
input [1:0]H_select;
input MF_select,Cin,clk,reset;
output reg Cout;
output reg [3:0]G;
wire carryout;
wire [3:0]o1,o2;
shifter sh1(A,H_select,clk,o2);
ALU al1(A,B,S,Cin,clk,o1,carryout);
always@(posedge clk/*A or B or S or reset or MF_select*/)
begin
if(reset)
	begin
		G = 0;
		Cout = carryout;
	end
	
else if(MF_select == 0 )
	begin 
		G = o1;
		Cout = carryout;
	end
else if(MF_select == 1)
	begin
		G = o2;
		Cout = 0;
	end
end

endmodule

module ALU(A,B,S,Cin,clk,g,cout);
input [3:0]A,B;
input [2:0]S;
input Cin,clk;
wire [3:0]data;
wire [3:0]carryout;

reg [3:0]c0,c1,c2,c3;
output reg [3:0]g;
output reg cout;

task adder;
input a,b,carryin;
input [1:0]s0;
reg y;
reg [1:0]ans;
output z,c;
begin
	/*if(b==0)
		y=s0[0];
		
	else if(b==1)
		y=s0[1];*/
		
	case(s0)
		2'b00: y = 0;
		2'b01: y = b;
		2'b10: y = (~b);
		2'b11: y = 1;
	endcase
		
	ans = a + y + carryin;
	c = ans[1];
	z = ans[0];

end
endtask
 
always@(/*posedge clk */S or A or B)
begin
	c0 = A & B;
	c1 = A | B;
	c2 = A ^ B;
	c3 = ~A;
	adder(A[0],B[0],Cin,S[1:0],data[0],carryout[0]);
	adder(A[1],B[1],carryout[0],S[1:0],data[1],carryout[1]);
	adder(A[2],B[2],carryout[1],S[1:0],data[2],carryout[2]);
	adder(A[3],B[3],carryout[2],S[1:0],data[3],carryout[3]);
	cout = carryout[3];
	if(S[2] == 0)
		begin
			g = data;
		end
	else if(S[2] == 1)
		begin
			case(S)
			3'd4: g = c0;
			3'd5: g = c1;
			3'd6: g = c2;
			3'd7: g = c3;
			
			endcase
		end

end

endmodule

module shifter(in,H_select,clk,out);
input [3:0]in;
input [1:0]H_select;
input clk;
output reg [3:0]out;

always@(/*posedge clk*/in or H_select)
begin
	case(H_select)
		2'b00:out = in;
		2'b01:out = in>>1;
		2'b10:out = in<<1;
		2'b11:out = in;
	endcase
end

endmodule

