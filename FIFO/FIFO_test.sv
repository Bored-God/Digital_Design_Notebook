module FIFO_test;

logic           ckop,clk,rst,w_en,r_en,em,fl;
logic   [7:0]   in,out;
logic   [7:0]   expected_queue[$];
logic   [7:0]   expected;    
    
task automatic queuestate;
    ckop = 0;
    if((w_en && !fl) || (r_en && w_en && fl))
        expected_queue.push_back(in);
    if(r_en && !em)begin
        expected = expected_queue.pop_front();
        ckop= 1;
        end
endtask

task automatic output_check;
        #1 if(expected !== out)
            $error("FAIL: Expected=%h, got=%h",expected,out);
        else
            $display("PASS: Expected=%h, got=%h",expected,out);
endtask

initial begin 
    clk = 0;
    forever #1 clk = ~clk;
end
always @ (posedge clk) begin
            queuestate();
            if(ckop)
            output_check();
        end
initial begin 
        rst = 1;    w_en = 0;   r_en = 0;               
   #2                           r_en = 1;               
   #2   rst = 0;    w_en = 1;   r_en = 0;   in = 8'd14; 
   #2                                       in = 8'd12; 
   #2               w_en = 0;               in = 8'd16; 
   #2                           r_en = 1;  in = 8'd115; 
   #2               w_en = 1;   r_en = 0;   in = 8'd87; 
   #2               w_en = 0;   r_en = 1;               
   #4               w_en = 1;   r_en = 0;   in = 8'd56; 
   #2                                       in = 8'd99; 
   #2                                       in = 8'd41; 
   #2                                       in = 8'd83; 
   #2                                       in = 8'd37; 
   #2                                       in = 8'd73; 
   #2                                       in = 8'd55; 
   #2                                       in = 8'd22; 
   #2               w_en = 0;   r_en = 1;               
   #18  $stop;
   end

FIFO m0 (.clk(clk),.rst(rst),.in(in),.out(out),.write_en(w_en),.read_en(r_en),.em(em),.fl(fl));



endmodule
