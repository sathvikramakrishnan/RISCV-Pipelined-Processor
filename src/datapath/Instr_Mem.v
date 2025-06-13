module Instr_Mem (
    input clk,
    input resetn,
    input enable,
    input [31:0] A,
    
    output reg [31:0] RD
);

    // Memory: 1024 32-bit registers
    reg [31:0] Instructions [0:2048];

    // Input address A is a byte-address
    // 1 word = 4 bytes
    always @(posedge clk or negedge resetn) begin
        if (~resetn) RD <= 32'd0;
        else if (enable) RD <= Instructions[A[31:2]];
    end

    initial begin
        $readmemh("memory/instructions.hex", Instructions);
    end

endmodule