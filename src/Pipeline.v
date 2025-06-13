module Pipeline (
    input clk,
    input resetn
);

    wire PCSrcE, StallF, FlushD;
    wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D;

    wire RegWriteW, StallD, FlushE, RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE;
    wire [4:0] RdW, Rs1E, Rs2E, RdE, Rs1D, Rs2D;

    wire [1:0] ForwardAE, ForwardBE;
    wire [1:0] ResultSrcE;
    wire [2:0] ALUControlE;
    wire [31:0] RD1E, RD2E, PCE, ImmExtE, PCPlus4E;

    wire RegWriteM, MemWriteM;
    wire [1:0] ResultSrcM;
    wire [31:0] ALUResultM, WriteDataM, PCPlus4M, ALUResultM_fb;
    wire [4:0] RdM;

    wire RegWriteW_reg;
    wire [1:0] ResultSrcW;
    wire [31:0] ALUResultW, ReadDataW, PCPlus4W, ResultW;

    Fetch_Cycle Fetch_Cycle (
        .clk(clk),
        .resetn(resetn),
        .PCSrcE(PCSrcE),
        .StallF(StallF),
        .StallD(StallD),
        .FlushD(FlushD),
        .PCTargetE(PCTargetE),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );

    Decode_Cycle Decode_Cycle (
        .clk(clk),
        .resetn(resetn),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .RdW(RdW),
        .ResultW(ResultW),
        .RegWriteW(RegWriteW),
        .FlushE(FlushE),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .JumpE(JumpE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .ALUSrcE(ALUSrcE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .PCE(PCE),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .RdE(RdE),
        .ImmExtE(ImmExtE),
        .PCPlus4E(PCPlus4E)
    );

    Execute_Cycle Execute_Cycle (
        .clk(clk),
        .resetn(resetn),
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .JumpE(JumpE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .ALUSrcE(ALUSrcE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .PCE(PCE),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .RdE(RdE),
        .ImmExtE(ImmExtE),
        .PCPlus4E(PCPlus4E),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .ResultW(ResultW),
        .ALUResultM_fb(ALUResultM_fb),
        .PCTargetE(PCTargetE),
        .PCSrcE(PCSrcE),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .MemWriteM(MemWriteM),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .RdM(RdM),
        .PCPlus4M(PCPlus4M)
    );

    Memory_Cycle Memory_Cycle (
        .clk(clk),
        .resetn(resetn),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .MemWriteM(MemWriteM),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .RdM(RdM),
        .PCPlus4M(PCPlus4M),
        .ALUResultM_fb(ALUResultM_fb),
        .RegWriteW_reg(RegWriteW_reg),
        .ResultSrcW(ResultSrcW),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .RdW(RdW),
        .PCPlus4W(PCPlus4W)
);

    Writeback_Cycle Writeback_Cycle (
        .RegWriteW_reg(RegWriteW_reg),
        .ResultSrcW(ResultSrcW),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .RdW(RdW),
        .PCPlus4W(PCPlus4W),
        .ResultW(ResultW),
        .RegWriteW(RegWriteW)
    );

    Hazard_Unit Hazard_Unit (
        .resetn(resetn),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .RdE(RdE),
        .PCSrcE(PCSrcE),
        .ResultSrcE_0(ResultSrcE[0]),
        .RdM(RdM),
        .RegWriteM(RegWriteM),
        .RdW(RdW),
        .RegWriteW(RegWriteW),
        .StallF(StallF),
        .StallD(StallD),
        .FlushD(FlushD),
        .FlushE(FlushE),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );

endmodule