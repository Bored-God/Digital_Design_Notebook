module Arbiter_test;
logic [3:0] req, grant;
logic [1:0] pr,gt;
logic clk,done;

initial begin 
    clk = 0;
    forever #1 clk = ~clk;
end
always @(posedge clk) begin
   req = 4'b1111; done = 1'd1;
end
initial begin 
# 24 $stop;
end


Arbiter m0 (req,grant,clk,done,pr,gt);
endmodule
