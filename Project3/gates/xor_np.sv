`include "./not_nb.sv"
`include "./and_np.sv"
`include "./or_np.sv"

//A XOR B = (A OR B) AND NOT(A AND B);

module xor_np #(
    parameter N = 2,  // Number of inputs
    parameter D = 16   // Bit width of each input
) (
    input logic [D-1:0] i_xor [N-1:0], // N inputs, each D bits wide
    output logic [D-1:0] o_xor         // D-bit output
);

wire [D-1:0] or_out;          // Output of OR operation
wire [D-1:0] and_out;         // Output of AND operation
wire [D-1:0] not_and_out;     // Inverted AND output

or_np #(
    .N(N),
    .D(D)
) u_or (
    .i_or(i_xor),        
    .o_or(or_out)       
);


and_np #(
    .N(N),
    .D(D)
) u_and (
    .i_and(i_xor),
    .o_and(and_out) 
);


not_nb #(
    .N(D)
) u_not (
    .i_a(and_out),
    .o_x(not_and_out)
);


and_np #(
    .N(2),
    .D(D)
) u_final_and (
    .i_and({or_out, not_and_out}),
    .o_and(o_xor)
);

endmodule
