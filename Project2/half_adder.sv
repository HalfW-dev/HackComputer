`include "./gates/xor_np.sv"
`include "./gates/and_np.sv"

module half_adder (
    input logic i_op_a,
    input logic i_op_b,

    output logic o_res,        // One D-bit output
    output logic o_carry
);

xor_np #(.N(2), .D(1)) xor_result (
    .i_xor({i_op_a, i_op_b}),
    .o_xor(o_res)
);

and_np #(.N(2), .D(1)) carry_result (
    .i_and({i_op_a, i_op_b}),
    .o_and(o_carry)
);

endmodule
