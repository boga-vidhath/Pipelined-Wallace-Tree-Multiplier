module RegisterChain #(parameter size=5, parameter stages=5)(in, clk, rst,out);
   input      [size-1:0] in;
   input      clk, rst;
   output     [size-1:0] out;
    // Register with active-high clock & asynchronous clear
    wire [size-1:0] intermediate_val [stages-2:0]; 
   Register #(.size(size)) Reg0 (.rst(rst), .clk(clk), .d(in),.q(intermediate_val[0]));
   genvar index;
   generate
   for (index=1; index <= stages-2; index=index+1)
     begin: gen_code_label
       Register #(.size(size)) PipeReg (.rst(rst), .clk(clk), .d(intermediate_val[index-1]),.q(intermediate_val[index]));
     end
   endgenerate
   assign out = intermediate_val[stages-2];
endmodule