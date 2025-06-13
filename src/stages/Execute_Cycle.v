module Execute_Cycle (
    input clk,
    input resetn,

    input RegWriteE,
    input [1:0] ResultSrcE,
    input MemWriteE,
    input JumpE,
    input BranchE,
    input [2:0] ALUControlE,
    input ALUSrcE,
    
    input [31:0] RD1E,
    input [31:0] RD2E,
    input [31:0] PCE,
    input [4:0] Rs1E,
    input [4:0] Rs2E,
    input [4:0] RdE,
    input [31:0] ImmExtE,
    input [31:0] PCPlus4E,

    input [1:0] ForwardAE,
    input [1:0] ForwardBE,
    input [31:0] ResultW,
    input [31:0] ALUResultM_fb,

    output [31:0] PCTargetE,
    output PCSrcE,

    output reg RegWriteM,
    output reg [1:0] ResultSrcM,
    output reg MemWriteM,

    output reg [31:0] ALUResultM,
    output reg [31:0] WriteDataM,
    output reg [4:0] RdM,
    output reg [31:0] PCPlus4M
);

    wire [31:0] SrcAE, SrcBE;
    wire [31:0] ALUResultE, WriteDataE;
    wire ZeroE;

    mux_4x1 mux_SrcA (
        .i0(RD1E),
        .i1(ResultW),
        .i2(ALUResultM_fb),
        .i3(),
        .select(ForwardAE),
        .out(SrcAE)
    );

    mux_4x1 mux_WriteData (
        .i0(RD2E),
        .i1(ResultW),
        .i2(ALUResultM_fb),
        .i3(),
        .select(ForwardBE),
        .out(WriteDataE)
    );

    mux_2x1 mux_SrcB (
        .i0(WriteDataE),
        .i1(ImmExtE),
        .select(ALUSrcE),
        .out(SrcBE)
    );

    ALU ALU (
        .A(SrcAE),
        .B(SrcBE),
        .ALUControl(ALUControlE),
        .Result(ALUResultE),
        .Z_(ZeroE),
        .N(),
        .C(),
        .V()
    );

    PCTarget PCTarget (
        .PC_(PCE),
        .ImmExt(ImmExtE),
        .PC_Target(PCTargetE)
    );

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            RegWriteM <= 1'b0;
            ResultSrcM <= 2'b00;
            MemWriteM <= 1'b0;
            ALUResultM <= {32{1'b0}};
            WriteDataM <= {32{1'b0}};
            RdM <= 5'b00000;
            PCPlus4M <= {32{1'b0}};
        end else begin
            RegWriteM <= RegWriteE;
            ResultSrcM <= ResultSrcE;
            MemWriteM <= MemWriteE;
            ALUResultM <= ALUResultE;
            WriteDataM <= WriteDataE;
            RdM <= RdE;
            PCPlus4M <= PCPlus4E;
        end
    end

    assign PCSrcE = (ZeroE & BranchE) | (JumpE);
    
endmodule