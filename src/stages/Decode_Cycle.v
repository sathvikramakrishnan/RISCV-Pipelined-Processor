module Decode_Cycle (
    input clk,
    input resetn,

    input [31:0] InstrD,
    input [31:0] PCD,
    input [31:0] PCPlus4D,
    input [4:0] RdW,
    input [31:0] ResultW,
    input RegWriteW,
    input FlushE,

    output [4:0] RdD,
    output [4:0] Rs1D,
    output [4:0] Rs2D,

    output reg RegWriteE,
    output reg [1:0] ResultSrcE,
    output reg MemWriteE,
    output reg JumpE,
    output reg BranchE,
    output reg [2:0] ALUControlE,
    output reg ALUSrcE,
    
    output reg [31:0] RD1E,
    output reg [31:0] RD2E,
    output reg [31:0] PCE,
    output reg [4:0] Rs1E,
    output reg [4:0] Rs2E,
    output reg [4:0] RdE,
    output reg [31:0] ImmExtE,
    output reg [31:0] PCPlus4E
);

    wire [31:0] RD1D, RD2D;
    wire [31:0] ImmExtD;

    // control wires
    wire RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD;
    wire [1:0] ResultSrcD, ImmSrcD;
    wire [2:0] ALUControlD;

    Reg_File Reg_File (
        .clk(clk),
        .resetn(resetn),
        .A1(InstrD[19:15]),
        .A2(InstrD[24:20]),
        .A3(RdW),
        .WD3(ResultW),
        .WE3(RegWriteW),

        .RD1(RD1D),
        .RD2(RD2D)
    );

    Extend Extend (
        .in(InstrD[31:7]),
        .ImmSrc(ImmSrcD),
        .ImmExt(ImmExtD)
    );

    Control_Unit Control_Unit (
        .Zero(),
        .op(InstrD[6:0]),
        .funct3(InstrD[14:12]),
        .funct7_5(InstrD[30]),

        .PCSrc(),
        .ResultSrc(ResultSrcD),
        .MemWrite(MemWriteD),
        .ALUSrc(ALUSrcD),
        .ImmSrc(ImmSrcD),
        .RegWrite(RegWriteD),
        .ALUControl(ALUControlD),
        .Branch(BranchD),
        .Jump(JumpD)
    );

    // pipeline register
    always @(posedge clk or negedge resetn) begin
        if (FlushE | ~resetn) begin
            RegWriteE <= 1'b0;
            ResultSrcE <= 2'b00;
            MemWriteE <= 1'b0;
            JumpE <= 1'b0;
            BranchE <= 1'b0;
            ALUControlE <= 3'b000;
            ALUSrcE <= 1'b0;

            RD1E <= 32'd0;
            RD2E <= 32'd0;
            PCE <= 32'd0;
            Rs1E <= 5'd0;
            Rs2E <= 5'd0;
            RdE <= 5'd0;
            ImmExtE <= 32'd0;
            PCPlus4E <= 32'd0;
        end

        else begin
            RegWriteE <= RegWriteD;
            ResultSrcE <= ResultSrcD;
            MemWriteE <= MemWriteD;
            JumpE <= JumpD;
            BranchE <= BranchD;
            ALUControlE <= ALUControlD;
            ALUSrcE <= ALUSrcD;

            RD1E <= RD1D;
            RD2E <= RD2D;
            PCE <= PCD;
            Rs1E <= Rs1D;
            Rs2E <= Rs2D;
            RdE <= RdD;
            ImmExtE <= ImmExtD;
            PCPlus4E <= PCPlus4D;
        end
    end

    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    assign RdD = InstrD[11:7];

endmodule