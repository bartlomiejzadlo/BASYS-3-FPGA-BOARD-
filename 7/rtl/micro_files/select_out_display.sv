`timescale 1 ns / 1 ps

module select_out_display(
    input wire clk,
    input wire rst,
    input logic [15:0] monRFData,
    input logic [15:0] monPC,
    input logic [15:0] monInstr,
    input logic RFData_en,
    input logic PC_en,
    input logic Instr_en,

    output logic [3:0] Dig1,
    output logic [3:0] Dig2,
    output logic [3:0] Dig3,
    output logic [3:0] Dig4
);

logic [3:0] Dig1_nxt, Dig2_nxt, Dig3_nxt, Dig4_nxt;

always_ff @(posedge clk) begin
    if(rst) begin
        Dig1 <= 4'b0;
        Dig2 <= 4'b0;
        Dig3 <= 4'b0;
        Dig4 <= 4'b0;
    end else begin
        Dig1 <= Dig1_nxt;
        Dig2 <= Dig2_nxt;
        Dig3 <= Dig3_nxt;
        Dig4 <= Dig4_nxt;
    end

end



always_comb begin
    if(RFData_en) begin
        Dig1_nxt = monRFData [3:0];
        Dig2_nxt = monRFData [7:4];
        Dig3_nxt = monRFData [11:8];
        Dig4_nxt = monRFData [15:12];
    end
    else if(PC_en) begin
        Dig1_nxt = monPC [3:0];
        Dig2_nxt = monPC [7:4];
        Dig3_nxt = monPC [11:8];
        Dig4_nxt = monPC [15:12];
    end
    else if(Instr_en) begin
        Dig1_nxt = monInstr [3:0];
        Dig2_nxt = monInstr [7:4];
        Dig3_nxt = monInstr [11:8];
        Dig4_nxt = monInstr [15:12];
    end
    else begin
        Dig1_nxt = 4'b1;
        Dig2_nxt = 4'b1;
        Dig3_nxt = 4'b1;
        Dig4_nxt = 4'b1;
    end
end



endmodule