module Data_Mem (
    input clk,
    input resetn,
    input [31:0] A,
    input [31:0] WD,
    input WE,
    
    output reg [31:0] RD
);

    reg [31:0] Data [0:4095];

    always @(negedge clk or negedge resetn) begin
        if (WE) begin 
            Data[A[31:2]] <= WD;
            #0.5 $writememh("memory/data_mod.hex", Data);
        end
        
        if (~resetn) RD <= 32'd0;
        else RD <= Data[A[31:2]];
    end

    initial begin
        $readmemh("memory/data.hex", Data);
    end

endmodule