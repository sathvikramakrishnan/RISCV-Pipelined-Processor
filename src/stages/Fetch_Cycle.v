module Fetch_Cycle(
    input clk,
    input resetn,
    
    input PCSrcE,
    input StallF,
    input StallD,
    input FlushD,
    input [31:0] PCTargetE,

    output reg [31:0] InstrD,
    output reg [31:0] PCD,
    output reg [31:0] PCPlus4D  
);

    wire [31:0] PC_F, PCF, PCPlus4F, InstrF;

    PC PC (
        .clk(clk),
        .resetn(resetn),
        .enable(~StallF),
        .PC_NEXT(PCPlus4F),
        .PC_(PC_F)
    );

    mux_2x1 PC_mux (
        .i0(PC_F),
        .i1(PCTargetE),
        .select(PCSrcE),
        .out(PCF)
    );

    Instr_Mem Instr_Mem (
        .clk(clk),
        .resetn(resetn),
        .enable(~StallF),
        .A(PCF),
        .RD(InstrF)
    );

    PCPlus4 PCPlus4 (
        .PC_(PCF),
        .PC_PLUS4(PCPlus4F)
    );

    // pipeline register
    always @(posedge clk or negedge resetn) begin
        if (FlushD | ~resetn) begin
            InstrD <= 32'd0;
            PCD <= 32'd0;
            PCPlus4D <= 32'd0;
        end

        else if (~StallD) begin
            InstrD <= InstrF;
            PCD <= PCF;
            PCPlus4D <= PCF;
        end
    end    

endmodule
