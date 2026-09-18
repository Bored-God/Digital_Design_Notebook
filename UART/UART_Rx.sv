`timescale 1ns / 1ps

typedef enum logic [1:0]
{
    idle,
    prep,
    trans,
    stop
} states;

module UART_Rx #(parameter clk_freq = 50_000_000, baud_rate = 9_800, stop_ticks = 1) (clk, rst, rx, data_out, done);
    input  logic       clk,rst,rx;
    output logic [7:0] data_out;
    output logic       done;
    localparam clk_per_bit = clk_freq / baud_rate;
    logic [7:0] buffer;
    logic [12:0] timer = 13'd0;
    logic [2:0] c;
    states s;
    logic trans_start = 0;

    always_ff @(posedge clk or posedge rst) begin

        if(rst) begin
            s <= idle;
            done <= 1'd0;
            data_out <= 8'd0;
            trans_start <= 0;
            timer <= 13'd0;
            buffer <= 8'd0;
        end
        else begin
            done <= 1'd0;
            case(s)
                idle:   begin
                            if(!rx)     begin 
                                timer <= 13'd0;
                                s <= prep;
                            end
                        end
                prep:   begin
                            if(timer < clk_per_bit/2 -1)    begin
                                timer <= timer + 1'd1;
                                end
                            else if (timer == clk_per_bit/2 - 1) begin
                                timer <= timer + 1'd1;
                                if(!rx) begin
                                    trans_start <=1'd1;
                                end
                                else begin
                                    s <= idle;
                                    trans_start <= 1'd0;
                               end
                            end
                            else if (timer == clk_per_bit -1) begin
                                    s <= trans;
                                    c <= 3'd0;
                                    timer <= 13'd0; 
                            end
                            else
                                timer <= timer + 1'd1;
                        end
                trans:  begin
                            if(timer == 13'd0 && trans_start) begin 
                                timer <= timer + 1'd1;
                                buffer[c] <= rx;           
                            end
                            else if(timer == clk_per_bit -1) begin
                                if (c == 3'd7) begin
                                    s <= stop;
                                    c <= 3'd0;
                                    trans_start <= 1'd0;
                                end     
                                else
                                    c <= c + 1'd1;
                                    
                                timer <= 13'd0;
                            end
                            else
                                timer <= timer + 1'd1;
                        end 

                stop:   begin
                            data_out <= buffer;
                            if (c == stop_ticks) begin 
                                        done <= 1'd1;
                                    end
                            else if(c < stop_ticks) begin 
                                if(timer == 13'd0) begin
                                    timer <= timer + 1;
                                    if(!rx) begin
                                        s <= idle;
                                        timer <= 13'd0;
                                        c <= 3'd0;
                                    end
                                end
                                else if(timer == clk_per_bit - 1) begin
                                    timer <= 13'd0;
                                    c <= c + 1'd1;    
                                end
                                else
                                    timer <= timer + 1'd1;
                            end
                            else begin 
                                s <= idle;
                                timer <= 13'd0;
                                c <= 3'd0;
                            end
                        end
            endcase
        end
    end
endmodule