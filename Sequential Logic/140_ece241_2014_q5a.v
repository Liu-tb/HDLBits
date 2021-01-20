module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 
    reg cout;
    always@(posedge clk or posedge areset) begin
        if(areset) begin
        	cout<=1;
            z<=0;
        end
        else begin
            cout<=cout&(~x);
            z<=x~^cout;
        end
    end
endmodule