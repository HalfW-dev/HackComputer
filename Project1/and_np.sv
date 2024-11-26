`include "./not_nb.sv"
`include "./nand_np.sv"

module and_np #(
    parameter N = 2,  // Number of inputs
    parameter D = 16   // Bit width of each input
) (
    input logic [D-1:0] i_and [N-1:0], // N inputs, each D bits wide
    output logic [D-1:0] o_and         // D-bit output
);

wire [D-1:0] nand_out;  // Intermediate wire for NAND output

nand_np #(
    .N(N), 
    .D(D)
) u_nand (
    .i_a(i_and),       
    .o_x(nand_out)     
);

not_nb #(
    .N(D)
) u_not (
    .i_a(nand_out),    
    .o_x(o_and)       
);

endmodule
