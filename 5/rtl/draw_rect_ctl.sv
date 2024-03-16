
`timescale 1 ns / 1 ps

module draw_rect_ctl (
    input logic         mouse_left,
    input logic [11:0]  mouse_xpos,
    input logic [11:0]  mouse_ypos,
    input logic clk,
    input logic rst,

    output logic [11:0] xpos,
    output logic [11:0] ypos

);


import vga_pkg::*;
logic [11:0] xpos_nxt, ypos_nxt, xpos_fall, ypos_fall, xpos_up, ypos_up;
logic clk_div;

typedef enum logic [3:0] {RUNNING, FALL1, FALL2, FALL3, FALL4, FALL5, FALL6, UP1, UP2, UP3, UP4, UP5, FALLEND} State;

State currentState = RUNNING, nextState;

always_ff @(posedge clk) begin : draw
    if (rst) begin
        xpos <= '0;
        ypos <= '0;
        currentState <= RUNNING;
    end
    else begin
        xpos <= xpos_nxt;
        ypos <= ypos_nxt;
        currentState <= nextState;
    end
end


always_ff @(posedge clk_div) begin
    xpos_fall <= xpos_nxt;
    ypos_fall <= ypos_nxt + 1;
end

always_ff @(posedge clk_div) begin
    xpos_up <= xpos_nxt;
    ypos_up <= ypos_nxt - 1;
end

always_ff @(posedge clk) begin
    case(currentState)
        RUNNING: begin
            xpos_nxt <= mouse_xpos;
            ypos_nxt <= mouse_ypos;
            if (mouse_left) begin
                if (ypos_nxt <= VER_PIXELS-400 ) begin
                nextState <= FALL1; 
                end
                else if (ypos_nxt > VER_PIXELS-400 && ypos_nxt <= VER_PIXELS-260 ) begin
                    nextState <= FALL2; 
                end
                else if (ypos_nxt > VER_PIXELS-260 && ypos_nxt <= VER_PIXELS-180  ) begin
                    nextState <= FALL3; 
                end
                else if (ypos_nxt > VER_PIXELS-180 && ypos_nxt <= VER_PIXELS-140  ) begin
                    nextState <= FALL4; 
                end
                else if (ypos_nxt > VER_PIXELS-140 && ypos_nxt <= VER_PIXELS-110  ) begin
                    nextState <= FALL5; 
                end
                else begin
                    nextState <= FALL6;
                end
            end
        end
        FALL1: begin
            if (ypos_nxt >= VER_PIXELS - H_OF_REC-1) begin
                nextState <= UP1;
            end
            xpos_nxt <= xpos_fall;
            ypos_nxt <= ypos_fall;
        end
        UP1: begin
            if (ypos_nxt <= VER_PIXELS - 180) begin
                nextState <= FALL2;
            end
            xpos_nxt <= xpos_up;
            ypos_nxt <= ypos_up;
        end
        FALL2: begin
            if (ypos_nxt >= VER_PIXELS - H_OF_REC-1) begin
                nextState <= UP2;
            end
            xpos_nxt <= xpos_fall;
            ypos_nxt <= ypos_fall;
        end
        UP2: begin
            if (ypos_nxt <= VER_PIXELS - 120) begin
                nextState <= FALL3;
            end
            xpos_nxt <= xpos_up;
            ypos_nxt <= ypos_up;
        end
        FALL3: begin
            if (ypos_nxt >= VER_PIXELS - H_OF_REC-1) begin
                nextState <= UP3;
            end
            xpos_nxt <= xpos_fall;
            ypos_nxt <= ypos_fall;
        end
        UP3: begin
            if (ypos_nxt <= VER_PIXELS - 80) begin
                nextState <= FALL4;
            end
            xpos_nxt <= xpos_up;
            ypos_nxt <= ypos_up;
        end
        FALL4: begin
            if (ypos_nxt >= VER_PIXELS - H_OF_REC-1) begin
                nextState <= UP4;
            end
            xpos_nxt <= xpos_fall;
            ypos_nxt <= ypos_fall;
        end
        UP4: begin
            if (ypos_nxt <= VER_PIXELS - 60) begin
                nextState <= FALL5;
            end
            xpos_nxt <= xpos_up;
            ypos_nxt <= ypos_up;
        end
        FALL5: begin
            if (ypos_nxt >= VER_PIXELS - H_OF_REC-1) begin
                nextState <= UP5;
            end
            xpos_nxt <= xpos_fall;
            ypos_nxt <= ypos_fall;
        end
        UP5: begin
            if (ypos_nxt <= VER_PIXELS - 50) begin
                nextState <= FALL6;
            end
            xpos_nxt <= xpos_up;
            ypos_nxt <= ypos_up;
        end
        FALL6: begin
            if (ypos_nxt >= VER_PIXELS - H_OF_REC-1) begin
                nextState <= FALLEND;
            end
            xpos_nxt <= xpos_fall;
            ypos_nxt <= ypos_fall;
        end
        FALLEND: begin
            xpos_nxt <= xpos_nxt;
            ypos_nxt <= ypos_nxt;
            if (rst) begin
                nextState <= RUNNING;
            end
        end

    endcase

end

d_bufor u_d_bufor(
    .clk,
    .rst,
    .clk_div(clk_div)
);


endmodule
