`timescale 1ns / 1ps

module UART_Tx #(parameter clk_freq = 50_000_000, baud_rate = 9_600, stop_ticks = 1) (data_in, tx, start,clk,rst,busy);
    localparam clk_per_bit = clk_freq/baud_rate;
    input   logic           clk,rst,start;
    input   logic   [7:0]   data_in;
    output  logic           tx,busy;
            logic   [7:0]   buffer = 8'd0;
            logic   [12:0]  timer;  
            logic   [2:0]   c;
            states          s = idle;

    
    always_ff @ (posedge clk or posedge rst) begin
        if(rst) begin
            buffer <= 8'd0;
            busy <= 1'd0;
            tx <= 1'd1;
            timer <= 13'd0;
            s <= idle;
            end
        else begin 
            case(s)
            idle:   begin 
                        tx <= 1'd1;
                        busy <= 1'd0;
                        if(start)begin
                            s <= prep;
                            timer <= 13'd0;
                        end
                    end
            prep:   begin 
                        if(timer == 13'd0) begin
                            buffer <= data_in;
                            busy <= 1'd1;
                            tx <= 1'd0;
                            c <= 0;
                            timer <= timer + 1'd1;
                            end
                        else if(timer == clk_per_bit - 1) begin
                            s <= trans;
                            timer <= 0;
                        end
                        else
                        timer <= timer + 1'd1;
                    end
            trans:  begin 
                        if(timer == 13'd0) begin
                            timer <= timer + 1'd1;
                            tx <= buffer[c];
                        end
                        else if(timer == clk_per_bit - 1) begin
                            if(c == 3'd7) begin   
                                s <= stop;
                                c <= 3'd0;
                                timer <= 13'd0;
                            end
                            else
                                c <= c + 3'd1;
                            
                            timer <= 13'd0;
                        end
                        else 
                            timer <= timer +1'd1;
                    end
            stop:   begin
                        tx <= 1'd1;
                        if(c == stop_ticks) begin
                                busy <= 1'd0;
                                c <= 3'd0;
                                s <= idle;
                            end
                        else if(timer == clk_per_bit-1) begin
                            c <= c + 1'd1;
                            timer <= 0;
                        end
                        else 
                            timer <= timer + 1'd1;
                    end
            endcase
        end
    end
endmodule
