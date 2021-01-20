module top_module (
    input clk,
    input d,
    output q
);
    reg h,l;
    always@(posedge clk)
        h <= d;
    always@(negedge clk)
        l <= d;
    assign q = clk?h:l;
endmodule