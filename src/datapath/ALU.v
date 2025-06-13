module ALU(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUControl,
    
    output reg [31:0] Result,
    output Z_,
    output N,
    output C,
    output V
);
    // connecting wires
    wire [31:0] sum;
    wire cin;
    wire cout;

    // Logic design
    assign cin = ALUControl[0];
    assign {cout, sum} = (~ALUControl[0]) ? A + B + cin : (A + ~B + cin);

    // output mux
    always @(*) begin
        case (ALUControl[2:0])
            3'b000: Result = sum;
            3'b001: Result = sum;
            3'b010: Result = A & B;
            3'b011: Result = A | B;
            3'b101: Result = { {31{1'b1}}, V^sum[31] };
            3'b110: Result = A ^ B;
            default: Result = {32{1'b1}};
        endcase
    end

    // Zero, Negative, Carry, oVerflow
    assign Z_ = &(~Result);
    assign N = Result[31];
    assign C = cout & ALUControl[1];
    assign V = ~(A[31] ^ B[31] ^ ALUControl[0]) & (A[31] ^ sum[31]) & ~(ALUControl[1]);

endmodule