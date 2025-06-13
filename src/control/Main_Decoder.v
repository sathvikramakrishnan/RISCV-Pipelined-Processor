module Main_Decoder(
    input [6:0] op,
    
    output Branch,
    output Jump,
    output [1:0] ResultSrc,
    output MemWrite,
    output ALUSrc,
    output [1:0] ImmSrc,
    output RegWrite,
    output [1:0] ALUOp
);

    assign Branch = (op == 7'd99);
    assign Jump = (op == 7'd111);
    assign ResultSrc = (op == 7'd3) ? 2'b01 : (op == 7'd111) ? 2'b10 : 2'b00;
    assign MemWrite = (op == 7'd35);
    assign ALUSrc = (op == 7'd3 | op == 7'd35 | op == 7'd19);
    assign ImmSrc = (op == 7'd35) ? 2'b01 : (op == 7'd99) ? 2'b10 : (op == 7'd111) ? 2'b11 : 2'b00;
    assign ALUOp = (op == 7'd51 | op == 7'd19) ? 2'b10 : (op == 7'd99) ? 2'b01 : 2'b00;
    assign RegWrite = (op == 7'd3 | op == 7'd51 | op == 7'd19 | op == 7'd111);

endmodule