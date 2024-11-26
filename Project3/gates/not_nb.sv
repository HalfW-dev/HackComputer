module not_nb #(
    parameter D = 16
)(
    input logic [D-1:0] i_nand,
    output logic [D-1:0] o_nand
);

assign o_nand = ~i_nand;

endmodule