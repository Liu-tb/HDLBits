module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output reg [3:0] count,
    output counting,
    output done,
    input ack);
	parameter S=0,S1=1,S11=2,S110=3,B0=4,B1=5,B2=6,B3=7,Count=8,Wait=9;
    reg[3:0] cs,ns;
    reg[9:0] counter;
    wire shift_ena,count_ena,done_counting;
    
    always@(*) begin
        case(cs)
            S:		ns = data?S1:S;
            S1:		ns = data?S11:S;
            S11:	ns = data?S11:S110;
            S110:	ns = data?B0:S;
            B0:		ns = B1;
            B1:		ns = B2;
            B2:		ns = B3;
            B3:		ns = Count;
            Count:	ns = done_counting?Wait:Count;
            Wait:	ns = ack?S:Wait;
            default: ns = S;
        endcase
    end
    
    always@(posedge clk)
        if(reset)
            cs <= S;
    	else
            cs <= ns;
    
    always@(posedge clk)
        if(shift_ena)
            count <= {count[2:0],data};
     	else if(count_ena)
            count <= count-1;
    	else
            count <= count;
    
    always@(posedge clk)
        if(counting&counter!=999)
            counter <= counter+1;
    	else
            counter <= 0;
        
    assign shift_ena = (cs==B0|cs==B1|cs==B2|cs==B3);
    assign count_ena = (cs==Count&counter==999);
    assign done_counting = (count==0&counter==999);
    assign counting = (cs==Count);
    assign done = (cs==Wait);
endmodule