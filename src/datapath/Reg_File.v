module Reg_File (
    input clk,
    input resetn,

    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    input WE3,

    output reg [31:0] RD1,
    output reg [31:0] RD2
);
    reg [31:0] Registers [0:31];

    always @(posedge clk) begin
        if (WE3) begin 
            Registers[A3] <= WD3;
            #0.5 $writememh("memory/registers_mod.hex", Registers);
        end
    end

    // the extra bypassing logic in this block is because of verilog simulation quirks
    // not required when running on hardware
    always @(negedge clk or negedge resetn) begin
        if (~resetn) begin
            RD1 <= 32'h00000000;
            RD2 <= 32'h00000000;
        end
        else begin
            RD1 <= (WE3 && A3 == A1) ? WD3 : Registers[A1];
            RD2 <= (WE3 && A3 == A2) ? WD3 : Registers[A2];
        end
    end

    /*     
    always @(negedge clk or negedge resetn) begin
        if (~resetn) begin
            RD1 <= 32'h00000000;
            RD2 <= 32'h00000000;
        end
        else begin
            RD1 <= Registers[A1];
            RD2 <= Registers[A2];
        end
    end
    */
     
    initial begin
        $readmemh("memory/registers.hex", Registers);
    end

endmodule