`timescale 1ns / 1ps
module FIFO(rst,clk,read_en,write_en,in,out);
    input   logic           read_en,write_en,clk,rst;
    input   logic   [7:0]   in;
    output  logic   [7:0]   out;
            logic           full,empty,read,write;
            logic   [3:0]   read_ptr=4'd0,write_ptr=4'd0;
            logic   [7:0]   regs    [0:7];

    always_comb begin 
        if(rst) begin 
                read_ptr <= 4'd0;
                write_ptr <= 4'd0;
                out <= 8'd0;
                end
        empty   =   (read_ptr == write_ptr);
        full    =   ((read_ptr[2:0] == write_ptr[2:0]) && (read_ptr[3] != write_ptr[3]));
        read = (read_en && !empty);
        write = ((write_en && !full) ||  (write_en && read_en && full));
    end
    always_ff @ (posedge clk) begin
           if(read) begin
                out <= regs[read_ptr[2:0]];
                read_ptr <= read_ptr + 1;
                end
            if (write) begin 
                regs[write_ptr[2:0]] <= in;
                write_ptr <= write_ptr+1;
                end
        end
endmodule
