module alu_nb #(
    parameter N = 16  // Number of bits (width of the inputs)
)(
    input  logic [N-1:0] i_op_a,       // Operand A, N bits
    input  logic [N-1:0] i_op_b,       // Operand B, N bits

    input  logic        zx,    // x=0
    input  logic        nx,    // x=!x
    input  logic        zy,    // y=0
    input  logic        ny,    // y=!y
    input  logic        f,    // f ? x+y : x&y
    input  logic        no,    // out = !out

    output logic [N-1:0] o_res,        // Sum output, N bits
    
    output logic        zr,
    output logic        ng,
    output logic        err
);

wire logic [5:0] opcode;
assign opcode = {zx, nx, zy, ny, f, no};

always_comb begin : calc
    case(opcode) 
        6'b101010: o_res = 0;
        6'b111111: o_res = 1;
        6'b111010: o_res = -1;

        6'b001100: o_res = i_op_a;
        6'b110000: o_res = i_op_b;

        6'b001101: o_res = ~(i_op_a);
        6'b110001: o_res = ~(i_op_b);

        6'b001111: o_res = -(i_op_a);
        6'b110011: o_res = -(i_op_b);

        6'b011111: o_res = i_op_a + 1;
        6'b110111: o_res = i_op_b + 1;

        6'b001110: o_res = i_op_a - 1;
        6'b110010: o_res = i_op_b - 1;

        6'b000010: o_res = i_op_a + i_op_b;
        6'b010011: o_res = i_op_a - i_op_b;
        6'b000111: o_res = i_op_b - i_op_a;

        6'b000000: o_res = i_op_a & i_op_b;
        6'b010101: o_res = i_op_a | i_op_b;

        default: begin
            err = 1;
            o_res = -1;
        end
    endcase
end
endmodule
