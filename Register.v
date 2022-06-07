module Register #(parameter size=5)(d, clk, rst, q);
   input      [size-1:0] d;
   input      clk, rst;
   output     [size-1:0] q;
   reg        [size-1:0] q;
    // Register with active-high clock & asynchronous clear
   always @ (posedge clk or posedge rst) begin
      if (rst)
         q <= 0;
      else
         q <= d;
   end
endmodule