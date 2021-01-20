module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [100:0] carry;
    assign carry[0]=cin;
    assign cout=carry[100];
    genvar i;
    generate for(i=0;i<=99;i=i+1)
        begin:bc
            bcd_fadd bcd({a[4*i+3],a[4*i+2],a[4*i+1],a[4*i]},{b[4*i+3],b[4*i+2],b[4*i+1],b[4*i]},carry[i],carry[i+1],{sum[4*i+3],sum[4*i+2],sum[4*i+1],sum[4*i]});
        end
    endgenerate
endmodule