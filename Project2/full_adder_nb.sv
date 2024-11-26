`include "./gates/xor_np.sv"
`include "./gates/and_np.sv"
`include "./half_adder.sv"  

module full_adder_nb #(
    parameter D = 16  // Number of bits (width of the inputs)
)(
    input  logic [D-1:0] i_op_a,       // Operand A, D bits
    input  logic [D-1:0] i_op_b,       // Operand B, D bits
    input  logic [D-1:0] i_carry_in,   // Carry-in, D bits

    output logic [D-1:0] o_sum,        // Sum output, D bits
    output logic [D-1:0] o_carry_out   // Carry-out, D bits
);

wire [D-1:0] half_sum;     // Intermediate result from first half adder
wire [D-1:0] half_carry;   // Carry from first half adder
wire [D-1:0] second_carry; // Carry from second half adder

genvar i;
generate
    for (i = 0; i < D; i = i + 1) begin : full_adder_bits

        halfadder ha1 (
            .i_op_a(i_op_a[i]),
            .i_op_b(i_op_b[i]),
            .o_res(half_sum[i]),
            .o_carry(half_carry[i])
        );

        halfadder ha2 (
            .i_op_a(half_sum[i]),
            .i_op_b(i_carry_in[i]),
            .o_res(o_sum[i]),
            .o_carry(second_carry[i])
        );

        or_np #(
            .N(2), .D(1)
        ) carry_out_or (
            .i_or({half_carry[i], second_carry[i]}),
            .o_or(o_carry_out[i])
        );

    end
endgenerate

endmodule
