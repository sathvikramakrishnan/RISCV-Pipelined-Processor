module Hazard_Unit (
    input resetn,
    input [4:0] Rs1D,
    input [4:0] Rs2D,

    input [4:0] Rs1E,
    input [4:0] Rs2E,
    input [4:0] RdE,
    input PCSrcE,
    input ResultSrcE_0,

    input [4:0] RdM,
    input RegWriteM,

    input [4:0] RdW,
    input RegWriteW,

    output StallF,
    output StallD,
    output FlushD,
    output FlushE,
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE
);
    wire lwStall;

    assign StallF = (~resetn) ? 1'b0 : lwStall;
    assign StallD = (~resetn) ? 1'b0 : lwStall;
    
    assign lwStall = (~resetn) ? 1'b0 : ResultSrcE_0 & ((Rs1D == RdE) | (Rs2D == RdE));
    assign FlushD = (~resetn) ? 1'b0 : PCSrcE;
    assign FlushE = (~resetn) ? 1'b0 : lwStall | PCSrcE;
    
    always @(*) begin
        if (~resetn)
            ForwardAE = 2'b00;
        else if (((Rs1E == RdM) & RegWriteM) & (Rs1E != 0)) 
            ForwardAE = 2'b10;
        else if (((Rs1E == RdW) & RegWriteW) & (Rs1E != 0))
            ForwardAE = 2'b01;
        else 
            ForwardAE = 2'b00;

        if (~resetn)
            ForwardBE = 2'b00;
        else if (((Rs2E == RdM) & RegWriteM) & (Rs2E != 0))
            ForwardBE = 2'b10;
        else if (((Rs2E == RdW) & RegWriteW) & (Rs2E != 0))
            ForwardBE = 2'b01;
        else 
            ForwardBE = 2'b00;
    end


endmodule