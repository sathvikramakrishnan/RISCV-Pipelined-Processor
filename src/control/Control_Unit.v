module Control_Unit (
    input Zero,
    input [6:0] op,
    input [2:0] funct3,
    input funct7_5,

    output PCSrc,
    output [1:0] ResultSrc,
    output MemWrite,
    output ALUSrc,
    output [1:0]ImmSrc,
    output RegWrite,
    output [2:0]ALUControl,
    output Branch,
    output Jump
);

    wire [1:0] ALUOp;

    Main_Decoder Main_Decoder(
        .op(op),
        .Branch(Branch),
        .Jump(Jump),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp)
    );

    ALU_Decoder ALU_Decoder(
        .ALUOp(ALUOp),
        .op5(op[5]),
        .funct3(funct3),
        .funct7_5(funct7_5),
        .ALUControl(ALUControl)
    );

    assign PCSrc = (Zero & Branch) | (Jump);

endmodule