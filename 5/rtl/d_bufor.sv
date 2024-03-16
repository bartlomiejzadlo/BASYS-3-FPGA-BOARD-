`timescale 1ns / 1ns
/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: BZ
 *
 * Description:
 *
 */

module d_bufor
    # ( parameter
           FREQ  = 400 
    )
    (
        input  wire clk, 
        input  wire rst,       
        output reg  clk_div   
    );


    localparam LOOP_COUNTER_AT = 40_000_000/ FREQ / 2 ;    

    reg [clog2(LOOP_COUNTER_AT)-1:0] count;                 

    always @( posedge(clk), posedge(rst) )            
    begin

        if(rst)
        begin : counter_reset
            count   <= #1 0;
            clk_div <= #1 1'b0;
        end

        else
        begin : counter_operate

            if (count == (LOOP_COUNTER_AT - 1))
            begin : counter_loop
                count   <= #1 0;
                clk_div <= #1 ~clk_div;
            end

            else
            begin : counter_increment
                count   <= #1 count + 1;
                clk_div <= #1 clk_div;
            end

        end
    end

 

    function integer clog2(input integer number);
        begin
            clog2 = 0;
            while (number)
            begin
                clog2  = clog2 + 1;
                number = number >> 1;
            end
        end
    endfunction

endmodule
