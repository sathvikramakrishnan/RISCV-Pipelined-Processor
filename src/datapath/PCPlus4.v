module PCPlus4 (
    input [31:0] PC_,
    output [31:0] PC_PLUS4
);

    // 1 word = 4 bytes
    assign PC_PLUS4 = PC_ + 32'd4;

endmodule