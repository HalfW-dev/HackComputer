`include "./not_nb.sv"
`include "./nand_np.sv"
`include "./and_np.sv"
`include "./or_np.sv"
`include "./xor_np.sv"

module demux_np #(
    parameter N = 2,  // Number of outputs
    parameter D = 16   // Bit width of the input
)(
    input logic [D-1:0] i_demux,            // Input, D bits wide
    input logic [$clog2(N)-1:0] i_sel,      // Select signal, log2(N) bits wide
    output logic [D-1:0] o_demux [N-1:0]    // N outputs, each D bits wide
);

wire [N-1:0] sel_decoded;                  // One-hot decoded select signal

genvar i;

generate
    for (i = 0; i < N; i = i + 1) begin : gen_sel_decoder
        assign sel_decoded[i] = (i_sel == i);  // One-hot decode select signal
    end
endgenerate

generate
    for (i = 0; i < N; i = i + 1) begin : gen_and_demux
        and_np #(
            .N(2),
            .D(D)
        ) u_and (
            .i_and({i_demux, {D{sel_decoded[i]}}}),
            .o_and(o_demux[i])
        );
    end
endgenerate

endmodule
