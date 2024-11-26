`include "dff.sv"

module bitreg(
    input clk_i,
    input rst_ni,

    input logic i_in,
    input logic i_load,

    output logic o_out
);

always @(posedge clk_i or negedge rst_ni) 
    begin
        if (!rst_ni)
            o_out <= 0;
        else if (i_load)
            o_out <= i_in;
        else
            o_out <= o_out; 
    end 

endmodule