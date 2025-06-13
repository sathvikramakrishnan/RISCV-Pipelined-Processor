module mux_2x1 (
    input [31:0] i0,
    input [31:0] i1,
    input select,
    output [31:0] out
);
    
    assign out = (select) ? i1 : i0;

endmodule