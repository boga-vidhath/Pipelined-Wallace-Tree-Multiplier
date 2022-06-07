
module WallaceTreeMult(
    input [4:0] A,
    input [4:0] B,
    input clk,
    input rst,
    output [9:0] Out
    );
    
    
    
    wire HA1_sum,HA2_sum,FA1_sum,FA2_sum,FA3_sum,FA4_sum;
    wire HA1_carry,HA2_carry,FA1_carry,FA2_carry,FA3_carry,FA4_carry;
    //Step-1
    HalfAdder HA1 (A[2]&B[0], A[1]&B[1], HA1_sum, HA1_carry);
    FullAdder FA1 (A[3]&B[0],A[2]&B[1],A[1]&B[2], FA1_sum, FA1_carry);
    FullAdder FA2 (A[4]&B[0],A[3]&B[1],A[2]&B[2], FA2_sum, FA2_carry);
    HalfAdder HA2 (A[1]&B[3],A[0]&B[4],HA2_sum,HA2_carry);
    FullAdder FA3 (A[1]&B[4],A[4]&B[1],A[3]&B[2], FA3_sum,FA3_carry);
    FullAdder FA4 (A[2]&B[4], A[3]&B[3], A[4]&B[2], FA4_sum, FA4_carry);   
    //Register-1
    wire HA1_sum_reg_out,HA1_carry_reg_out, FA1_sum_reg_out, FA1_carry_reg_out, FA2_sum_reg_out, FA2_carry_reg_out;
    wire HA2_sum_reg_out,HA2_carry_reg_out, FA3_sum_reg_out, FA3_carry_reg_out, FA4_sum_reg_out, FA4_carry_reg_out;
    Register #(.size(1)) HA1_sum_reg (.rst(rst), .clk(clk), .d(HA1_sum),.q(HA1_sum_reg_out));
    Register #(.size(1)) HA1_carry_reg (.rst(rst), .clk(clk), .d(HA1_carry),.q(HA1_carry_reg_out));
    
    Register #(.size(1)) FA1_sum_reg (.rst(rst), .clk(clk), .d(FA1_sum),.q(FA1_sum_reg_out));
    Register #(.size(1)) FA1_carry_reg (.rst(rst), .clk(clk), .d(FA1_carry),.q(FA1_carry_reg_out));
    
    Register #(.size(1)) FA2_sum_reg (.rst(rst), .clk(clk), .d(FA2_sum),.q(FA2_sum_reg_out));
    Register #(.size(1)) FA2_carry_reg (.rst(rst), .clk(clk), .d(FA2_carry),.q(FA2_carry_reg_out));
    
    Register #(.size(1)) HA2_sum_reg (.rst(rst), .clk(clk), .d(HA2_sum),.q(HA2_sum_reg_out));
    Register #(.size(1)) HA2_carry_reg (.rst(rst), .clk(clk), .d(HA2_carry),.q(HA2_carry_reg_out));
    
    Register #(.size(1)) FA3_sum_reg (.rst(rst), .clk(clk), .d(FA3_sum),.q(FA3_sum_reg_out));
    Register #(.size(1)) FA3_carry_reg (.rst(rst), .clk(clk), .d(FA3_carry),.q(FA3_carry_reg_out));
        
    Register #(.size(1)) FA4_sum_reg (.rst(rst), .clk(clk), .d(FA4_sum),.q(FA4_sum_reg_out));
    Register #(.size(1)) FA4_carry_reg (.rst(rst), .clk(clk), .d(FA4_carry),.q(FA4_carry_reg_out));
    //Step-2
    wire HA_2_1_sum,FA_2_1_sum,FA_2_2_sum,HA_2_2_sum,FA_2_3_sum;
    wire HA_2_1_carry,FA_2_1_carry,FA_2_2_carry,HA_2_2_carry,FA_2_3_carry;
    
    HalfAdder HA_2_1 (FA1_sum_reg_out,HA1_carry_reg_out,HA_2_1_sum,HA_2_1_carry);//Checked
    FullAdder FA_2_1 (FA1_carry_reg_out,FA2_sum_reg_out,HA2_sum_reg_out,FA_2_1_sum,FA_2_1_carry);//Checked
    FullAdder FA_2_2 (FA3_sum_reg_out,FA2_carry_reg_out,HA2_carry_reg_out,FA_2_2_sum,FA_2_2_carry);//Checked    
    HalfAdder HA_2_2 (FA4_sum_reg_out,FA3_carry_reg_out,HA_2_2_sum,HA_2_2_carry);//Checked
    FullAdder FA_2_3 (A[3]&B[4],A[4]&B[3],FA4_carry_reg_out,FA_2_3_sum,FA_2_3_carry);//Checked
    
    wire HA_2_1_sum_reg_out,HA_2_1_carry_reg_out, FA_2_1_sum_reg_out, FA_2_1_carry_reg_out, FA_2_2_sum_reg_out, FA_2_2_carry_reg_out;
    wire HA_2_2_sum_reg_out,HA_2_2_carry_reg_out, FA_2_3_sum_reg_out, FA_2_3_carry_reg_out;
    Register #(.size(1)) HA_2_1_sum_reg (.rst(rst), .clk(clk), .d(HA_2_1_sum),.q(HA_2_1_sum_reg_out));
    Register #(.size(1)) HA_2_1_carry_reg (.rst(rst), .clk(clk), .d(HA_2_1_carry),.q(HA_2_1_carry_reg_out));
        
    Register #(.size(1)) FA_2_1_sum_reg (.rst(rst), .clk(clk), .d(FA_2_1_sum),.q(FA_2_1_sum_reg_out));
    Register #(.size(1)) FA_2_1_carry_reg (.rst(rst), .clk(clk), .d(FA_2_1_carry),.q(FA_2_1_carry_reg_out));
        
    Register #(.size(1)) FA_2_2_sum_reg (.rst(rst), .clk(clk), .d(FA_2_2_sum),.q(FA_2_2_sum_reg_out));
    Register #(.size(1)) FA_2_2_carry_reg (.rst(rst), .clk(clk), .d(FA_2_2_carry),.q(FA_2_2_carry_reg_out));
        
    Register #(.size(1)) HA_2_2_sum_reg (.rst(rst), .clk(clk), .d(HA_2_2_sum),.q(HA_2_2_sum_reg_out));
    Register #(.size(1)) HA_2_2_carry_reg (.rst(rst), .clk(clk), .d(HA_2_2_carry),.q(HA_2_2_carry_reg_out));
        
    Register #(.size(1)) FA_2_3_sum_reg (.rst(rst), .clk(clk), .d(FA_2_3_sum),.q(FA_2_3_sum_reg_out));
    Register #(.size(1)) FA_2_3_carry_reg (.rst(rst), .clk(clk), .d(FA_2_3_carry),.q(FA_2_3_carry_reg_out));
    
    //Register-2
    //Step-3
    wire HA_3_1_sum, HA_3_2_sum, HA_3_3_sum, HA_3_4_sum;
    wire HA_3_1_carry, HA_3_2_carry, HA_3_3_carry, HA_3_4_carry;
    HalfAdder HA_3_1 (FA_2_2_sum_reg_out,FA_2_1_carry_reg_out,HA_3_1_sum,HA_3_1_carry);
    HalfAdder HA_3_2 (HA_2_2_sum_reg_out,FA_2_2_carry_reg_out,HA_3_2_sum,HA_3_2_carry);
    HalfAdder HA_3_3 (FA_2_3_sum_reg_out,HA_2_2_carry_reg_out,HA_3_3_sum,HA_3_3_carry);
    HalfAdder HA_3_4 (A[4]&B[4],FA_2_3_carry_reg_out,HA_3_4_sum,HA_3_4_carry);
    
    wire HA_3_1_sum_reg_out,HA_3_1_carry_reg_out, HA_3_2_sum_reg_out, HA_3_2_carry_reg_out, HA_3_3_sum_reg_out, HA_3_3_carry_reg_out;
    wire HA_3_4_sum_reg_out,HA_3_4_carry_reg_out;
    Register #(.size(1)) HA_3_1_sum_reg (.rst(rst), .clk(clk), .d(HA_3_1_sum),.q(HA_3_1_sum_reg_out));
    Register #(.size(1)) HA_3_1_carry_reg (.rst(rst), .clk(clk), .d(HA_3_1_carry),.q(HA_3_1_carry_reg_out));
            
    Register #(.size(1)) HA_3_2_sum_reg (.rst(rst), .clk(clk), .d(HA_3_2_sum),.q(HA_3_2_sum_reg_out));
    Register #(.size(1)) HA_3_2_carry_reg (.rst(rst), .clk(clk), .d(HA_3_2_carry),.q(HA_3_2_carry_reg_out));
            
    Register #(.size(1)) HA_3_3_sum_reg (.rst(rst), .clk(clk), .d(HA_3_3_sum),.q(HA_3_3_sum_reg_out));
    Register #(.size(1)) HA_3_3_carry_reg (.rst(rst), .clk(clk), .d(HA_3_3_carry),.q(HA_3_3_carry_reg_out));
            
    Register #(.size(1)) HA_3_4_sum_reg (.rst(rst), .clk(clk), .d(HA_3_4_sum),.q(HA_3_4_sum_reg_out));
    Register #(.size(1)) HA_3_4_carry_reg (.rst(rst), .clk(clk), .d(HA_3_4_carry),.q(HA_3_4_carry_reg_out));
    
    //Step-4 Final Addition Stage
    //Register-3
    wire A1_B0_reg_out;
    RegisterChain #(.size(1),.stages(4)) A1_B0_RegChain (.in(A[1]&B[0]), .clk(clk), .rst(rst),.out(A1_B0_reg_out));
    
    wire A0_B0_reg_out;
    RegisterChain #(.size(1),.stages(4)) A0_B0_RegChain (.in(A[0]&B[0]), .clk(clk), .rst(rst),.out(A0_B0_reg_out));
    
    wire A2_B3_reg_out;
    RegisterChain #(.size(1),.stages(4)) A2_B3_RegChain (.in(A[2]&B[3]), .clk(clk), .rst(rst),.out(A2_B3_reg_out));
    
    wire A0_B3_reg_out;
    RegisterChain #(.size(1),.stages(4)) A0_B3_RegChain (.in(A[0]&B[3]), .clk(clk), .rst(rst),.out(A0_B3_reg_out));
    
    wire A0_B2_reg_out;
    RegisterChain #(.size(1),.stages(4)) A0_B2_RegChain (.in(A[0]&B[2]), .clk(clk), .rst(rst),.out(A0_B2_reg_out));
    
    wire A0_B1_reg_out;
    RegisterChain #(.size(1),.stages(4)) A0_B1_RegChain (.in(A[0]&B[1]), .clk(clk), .rst(rst),.out(A0_B1_reg_out));
    
    wire [9:0] arg1 = {1'b0,HA_3_4_sum_reg_out,HA_3_3_sum_reg_out,HA_3_2_sum_reg_out,HA_3_1_sum_reg_out,FA_2_1_sum_reg_out,HA_2_1_sum_reg_out,HA1_sum_reg_out,A1_B0_reg_out,A0_B0_reg_out};
    wire [9:0] arg2 = {HA_3_4_carry_reg_out,HA_3_3_carry_reg_out,HA_3_2_carry_reg_out,HA_3_1_carry_reg_out,A2_B3_reg_out,HA_2_1_carry_reg_out,A0_B3_reg_out,A0_B2_reg_out,A0_B1_reg_out,1'b0};
    wire [9:0] arg1_reg_out, arg2_reg_out;
    Register #(.size(10)) arg1_reg (.rst(rst), .clk(clk), .d(arg1),.q(arg1_reg_out));
    Register #(.size(10)) arg2_reg (.rst(rst), .clk(clk), .d(arg2),.q(arg2_reg_out));
    //Register-4
    //Ste-5
    assign Out = arg1_reg_out + arg2_reg_out;
    
    
endmodule
