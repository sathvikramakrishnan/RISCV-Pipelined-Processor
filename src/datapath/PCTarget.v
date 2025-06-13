module PCTarget (
    input [31:0] PC_,
    input [31:0] ImmExt,
    output [31:0] PC_Target
);
    // subtract 4 to set offset relative to current instruction and not PC
    assign PC_Target = PC_ + ImmExt - 4;

endmodule