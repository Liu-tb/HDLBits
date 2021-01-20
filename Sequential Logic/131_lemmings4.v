module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
	parameter l=0,r=1,al=2,ar=3,dr=4,dl=5,die=6;
    reg [2:0] cs,ns;
    integer count;
    always@(posedge clk or posedge areset)
        if(areset)
            cs<=l;
    	else
            cs<=ns;
    always@(posedge clk)
        case(cs)
            al,ar:count=count+1;
            default:count=0;
        endcase
    always@(*)
        case(cs)
            l:begin
                if(~ground)
                    ns=al;
                else if(dig)
                    ns=dl;
                else if(bump_left)
                    ns=r;
                else
                    ns=l;
            end
            r:begin
                if(~ground)
                    ns=ar;
                else if(dig)
                    ns=dr;
                else if(bump_right)
                    ns=l;
                else
                    ns=r;
            end
            al:begin
                if(ground&count<20)
                    ns=l;
                else if(~ground)
                    ns=al;
                else
                    ns=die;
            end
            ar:begin
                if(ground&count<20)
                    ns=r;
                else if(~ground)
                    ns=ar;
                else
                    ns=die;
            end
            dr:begin
                if(ground)
                    ns=dr;
                else
                    ns=ar;
            end
            dl:begin
                if(ground)
                    ns=dl;
                else
                    ns=al;
            end
            die:ns=die;
        endcase
    assign walk_left=(cs==l);
    assign walk_right=(cs==r);
    assign aaah=((cs==al)|(cs==ar));
    assign digging=(cs==dr)|(cs==dl);
endmodule