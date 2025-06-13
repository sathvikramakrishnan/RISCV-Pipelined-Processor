module PC (
    input clk,
    input resetn,
    input enable,
    input [31:0] PC_NEXT,
    output reg [31:0] PC_
);
    always @(posedge clk or negedge resetn) begin
        if (~resetn) PC_ <= 32'h00000000;
        else if (enable) PC_ <= PC_NEXT;
    end

endmodule