module nand_np #(
    parameter N = 2,  // Number of inputs
    parameter D = 16   // Bit width of each input
)(
    input logic [D-1:0] i_nand [N-1:0],  // N inputs, each D bits wide
    output logic [D-1:0] o_nand        // One D-bit output
);

genvar i;
generate
    for (i = 0; i < D; i = i + 1) begin : gen_nand
        assign o_nand[i] = ~( &i_nand[:,i] ); // Perform reduction AND on all N inputs for each bit position
    end
endgenerate

endmodule
