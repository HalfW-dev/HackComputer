module dff(
    input   D,
    input   clk_i,
    input   rst_ni,
    output reg Q
);
    
always @(posedge clk_i or negedge rst_ni) 
    begin
        if (!rst_ni)
            Q <= 1'b0; 
        else 
            Q <= D; 
    end 
endmodule 