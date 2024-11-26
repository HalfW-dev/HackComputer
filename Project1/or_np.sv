`include "./not_nb.sv"
`include "./and_np.sv"

module or_np #(
    parameter N = 2,  // Number of inputs
    parameter D = 16   // Bit width of each input
) (
    input logic [D-1:0] i_or [N-1:0], // N inputs, each D bits wide
    output logic [D-1:0] o_or         // D-bit output
);

wire [D-1:0] not_inputs [N-1:0];  // Array to store NOT-ed inputs
wire [D-1:0] and_out;             // Intermediate wire for AND output

genvar i;
generate
    for (i = 0; i < N; i = i + 1) begin : gen_not_input
        not_nb #(
            .N(D)
        ) u_not (
            .i_a(i_or[i]),        
            .o_x(not_inputs[i])   
        );
    end
endgenerate

and_np #(
    .N(N),
    .D(D)
) u_and (
    .i_and(not_inputs),   
    .o_and(and_out)       
);

not_nb #(
    .N(D)
) u_not_final (
    .i_a(and_out),        
    .o_x(o_or)            
);

endmodule
