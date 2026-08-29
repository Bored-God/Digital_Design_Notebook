module FIFO_test;

logic           clk,rst,w_en,r_en;
logic   [7:0]   in,out;

initial begin 
    clk = 0;
    forever #1 clk = ~clk;
end

initial begin 
        rst = 1;    w_en = 0;   r_en = 0; 
   #2                           r_en = 1;
   #2   rst = 0;    w_en = 1;   r_en = 0;   in = 8'd14;
   #2                                       in = 8'd12;
   #2               w_en = 0;               in = 8'd16;
   #2                           r_en = 1;   in = 8'd115;
   #2               w_en = 1;   r_en = 0;   in = 8'd87;
   #2               w_en = 0;   r_en = 1;
   #4               w_en = 1;   r_en = 0;   in = 8'd56;
   #2                                       in = 8'd99;
   #2                                       in = 8'd41;
   #2                                       in = 8'd83;
   #2                                       in = 8'd37;
   #2                                       in = 8'd73;
   #2                                       in = 8'd55;
   #2                           r_en = 1;   in = 8'd22;
   #2               w_en = 0;            
   #14  $stop;
   end

FIFO m0 (.clk(clk),.rst(rst),.in(in),.out(out),.write_en(w_en),.read_en(r_en));

endmodule
