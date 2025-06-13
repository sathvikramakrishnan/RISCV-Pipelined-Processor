module Pipeline_tb ();

    reg clk = 1'b0;
    reg resetn;

    Pipeline Pipeline (
        .clk(clk),
        .resetn(resetn)
    );

    initial begin
        $dumpfile("pipeline.vcd");
        $dumpvars(0);
        #250 $finish;
    end

    initial begin
        forever #10 clk = ~clk;
    end

    initial begin
        resetn <= 1'b0;
        #5 resetn = 1'b1;
    end

endmodule