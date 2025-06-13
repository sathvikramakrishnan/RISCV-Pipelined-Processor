module mux_4x1 (
    input [31:0] i0,
    input [31:0] i1,
    input [31:0] i2,
    input [31:0] i3,
    input [1:0] select,
    
    output reg [31:0] out
);

    always @(*) begin
        case (select)
            2'b00: out = i0;
            2'b01: out = i1;
            2'b10: out = i2;
            2'b11: out = i3;
            default: out = 32'd0;
        endcase
    end 

endmodule