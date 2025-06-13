module Extend (
    input [31:7] in,
    input [1:0] ImmSrc,
    output reg [31:0] ImmExt
);

    always @(*) begin
        case (ImmSrc)
            2'b00: ImmExt = { {20{in[31]}}, in[31:20]};
            2'b01: ImmExt = { {20{in[31]}}, in[31:25], in[11:7]};
            2'b10: ImmExt = { {20{in[31]}}, in[7], in[30:25], in[11:8], 1'b0};
            2'b11: ImmExt = { {12{in[31]}}, in[19:12], in[20], in[30:21], 1'b0};
            default: ImmExt = 32'd0;
        endcase
    end

endmodule