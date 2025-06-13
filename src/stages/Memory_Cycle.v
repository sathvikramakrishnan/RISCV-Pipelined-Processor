module Memory_Cycle (
    input clk,
    input resetn,

    input RegWriteM,
    input [1:0] ResultSrcM,
    input MemWriteM,

    input [31:0] ALUResultM,
    input [31:0] WriteDataM,
    input [4:0] RdM,
    input [31:0] PCPlus4M,

    output [31:0] ALUResultM_fb,

    output reg RegWriteW_reg,
    output reg [1:0] ResultSrcW,
    
    output reg [31:0] ALUResultW,
    output reg [31:0] ReadDataW,
    output reg [4:0] RdW,
    output reg [31:0] PCPlus4W
);

    wire [31:0] ReadDataM;

    Data_Mem Data_Mem (
        .clk(clk),
        .resetn(resetn),
        .A(ALUResultM),
        .WD(WriteDataM),
        .WE(MemWriteM),
        .RD(ReadDataM)
    );

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            RegWriteW_reg <= 1'b0;
            ResultSrcW <= 2'b0;

            ALUResultW <= {32{1'b0}};
            ReadDataW <= {32{1'b0}};
            RdW <= {5{1'b0}};
            PCPlus4W <= {32{1'b0}};
        end 
        else begin
            RegWriteW_reg <= RegWriteM;
            ResultSrcW <= ResultSrcM;

            ALUResultW <= ALUResultM;
            ReadDataW <= ReadDataM;
            RdW <= RdM;
            PCPlus4W <= PCPlus4M;
        end
    end

    assign ALUResultM_fb = ALUResultM;

endmodule