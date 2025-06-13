module ALU_Decoder(
    input [1:0] ALUOp,
    input op5,
    input [2:0] funct3,
    input funct7_5,
    output reg [2:0] ALUControl
);
    wire [1:0] concat;
    assign concat = {op5, funct7_5};

    always @(*) begin
        case (ALUOp)
        2'b00: ALUControl = 3'b000;
        2'b01: ALUControl = 3'b001;
        2'b10: ALUControl = (funct3 == 3'b000) ? ((concat == 2'b11) ? 3'b001 : 3'b000) : 
            (funct3 == 3'b010) ? 3'b101 : 
            (funct3 == 3'b110) ? 3'b011 : 
            (funct3 == 3'b111) ? 3'b010 : 
            (funct3 == 3'b100) ? 3'b110 : 3'b000;
        endcase
    end

endmodule