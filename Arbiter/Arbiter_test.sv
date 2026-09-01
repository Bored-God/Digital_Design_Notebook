module Arbiter_test;
logic [3:0] req, grant;
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

assert property(@(posedge clk)(req == 4'd0)|->(grant == 4'd0));
assert property(@(posedge clk)(grant & ~req) == 4'd0);
assert property(@(posedge clk) $onehot0(grant));

Arbiter m0 (req,grant,clk,done);
endmodule
