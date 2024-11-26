`include "./bitreg.sv"

module reg_nb #(
    parameter D = 16
) (
    input clk_i,
    input rst_ni,

    input logic [D-1:0] i_in,
    input logic i_load,

    output logic [D-1:0] o_out
);

genvar i;
generate
    for(i = D-1; i >= 0; i = i - 1) begin : register
        bitreg bitr (
            .clk_i(clk_i),
            .rst_ni(rst_ni),
            .i_in(i_in[i]),
            .i_load(i_load),
            .o_out(o_out[i])
        );
    end
endgenerate

endmodule


