module Arbiter(req,grant,clk,done);
input   logic   [3:0]   req;
input   logic           clk,done;
output  logic   [3:0]   grant;
        logic   [1:0]   pri = 2'd0,gtd;

always_comb begin 
        grant = 4'd0;
        gtd = 2'd0;
        case (pri)
         2'b00: begin 
            if(req[0]) begin
                grant = 4'b0001; gtd = 2'd0; end
            else if(req[1])begin
                grant = 4'b0010; gtd = 2'd1; end
            else if(req[2])begin
                grant = 4'b0100; gtd = 2'd2; end
            else if(req[3])begin
                grant = 4'b1000; gtd = 2'd3; end
            end   
        
        2'b01: begin 
            if(req[1])begin
                grant = 4'b0010; gtd = 2'd1; end
            else if(req[2])begin
                grant = 4'b0100; gtd = 2'd2; end
            else if(req[3])begin
                grant = 4'b1000; gtd = 2'd3; end
            else if(req[0])begin
                grant = 4'b0001; gtd = 2'd0; end
            end
        
        2'b10: begin 
            if(req[2])begin
                grant = 4'b0100; gtd = 2'd2; end
            else if(req[3])begin
                grant = 4'b1000; gtd = 2'd3; end
            else if(req[0])begin
                grant = 4'b0001; gtd = 2'd0; end
            else if(req[1])begin
                grant = 4'b0010; gtd = 2'd1; end
            end
        
        2'b11: begin 
            if(req[3])begin
                grant = 4'b1000; gtd = 2'd3; end
            else if(req[0])begin
                grant = 4'b0001; gtd = 2'd0; end
            else if(req[1])begin
                grant = 4'b0010; gtd = 2'd1; end
            else if(req[2])begin
                grant = 4'b0100; gtd = 2'd2; end
            end
        endcase
    end
    
always_ff @(posedge clk) begin
        if(done) 
            pri <= gtd+1;
end
endmodule
