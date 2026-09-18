module UART_Test;
    logic clk1,clk2,rst1,rst2,busy,done,trans_line,start;
    logic [7:0] data_in, data_out;

    initial begin
    clk1 = 0;
    forever #1 clk1 = ~clk1; 
    end
    
    initial begin
    clk2 = 0;
    forever #2 clk2 = ~clk2;
    end
    
    initial begin
    rst1 = 1;
    rst2 = 1;
    start = 0;
    data_in = 8'h00;

    #5;

    rst1 = 0;
    rst2 = 0;

    @(negedge clk1);
    data_in = 8'h53;
    start = 1;

    @(negedge clk1);
    start = 0;

    wait(done);

    if(data_out == 8'h53)
        $display("PASS: received %h", data_out);
    else
        $error("FAIL: expected 53, got %h", data_out);

    $stop;
    end

UART_Tx #(500_000_000, 115200, 2) m0 (.clk(clk1),.rst(rst1),.tx(trans_line),.data_in (data_in) ,.busy(busy),.start(start));
UART_Rx #(250_000_000, 115200, 2) m1 (.clk(clk2),.rst(rst2),.rx(trans_line),.data_out(data_out),.done(done));
endmodule
