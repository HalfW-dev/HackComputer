`include "./gates/xor_np.sv"
`include "./gates/and_np.sv"
`include "./full_adder_nb.sv"    

module indecrementer_nb #(
    parameter D = 16  // Number of bits (width of the inputs)
)(
    input  logic [D-1:0]    i_op_a,       // Operand A, D bits
    input  logic            mode,         // Mode: 1 = increment, 0 = decrement

    output logic [D-1:0]    o_sum         // Sum output, D bits
);

logic [D-1:0] op_select;

// Select between +1 for increment and -1 for decrement (two's complement)
assign op_select = mode ? {D{1'b0}} + 1 : {D{1'b1}}; 

// Instantiate the full adder
fulladder #(.D(D)) indecrementer (
    .i_op_a(i_op_a),         // Operand A
    .i_op_b(op_select),      // Add either +1 or -1
    .i_carry_in(1'b0),       // No carry-in for increment/decrement
    .o_sum(o_sum),           // Sum output (incremented or decremented value)
    .o_carry_out()           // Carry-out (not needed for increment/decrement)
);

endmodule
