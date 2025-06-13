module Writeback_Cycle (
    input RegWriteW_reg,
    input [1:0] ResultSrcW,

    input [31:0] ALUResultW,
    input [31:0] ReadDataW,
    input [4:0] RdW,
    input [31:0] PCPlus4W,

    output [31:0] ResultW,
    output RegWriteW
);

    mux_4x1 mux_WB (
        .i0(ALUResultW),
        .i1(ReadDataW),
        .i2(PCPlus4W),
        .i3(),
        .select(ResultSrcW),
        .out(ResultW)
    );

    assign RegWriteW = RegWriteW_reg;

endmodule