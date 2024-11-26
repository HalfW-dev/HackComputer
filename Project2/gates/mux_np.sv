`include "./not_nb.sv"
`include "./nand_np.sv"
`include "./and_np.sv"
`include "./or_np.sv"
`include "./xor_np.sv"

module mux_np #(
    parameter N = 2,  // Number of inputs
    parameter D = 16   // Bit width of each input
)(
    input logic [D-1:0] i_mux [N-1:0],   // N inputs, each D bits wide
    input logic [$clog2(N)-1:0] i_sel,   // Select signal (log2(N) bits wide)
    output logic [D-1:0] o_mux           // MUX output, D bits wide
);

wire [N-1:0] sel_decoded;                
wire [D-1:0] and_results [N-1:0];        

genvar i;

generate
    for (i = 0; i < N; i = i + 1) begin : gen_sel_decoder
        assign sel_decoded[i] = (i_sel == i);  // One-hot decode select signal
    end
endgenerate

generate
    for (i = 0; i < N; i = i + 1) begin : gen_and_mux
        and_np #(
            .N(2),
            .D(D)
        ) u_and (
            .i_and({i_mux[i], {D{sel_decoded[i]}}}),  
            .o_and(and_results[i])                    
        );
    end
endgenerate

or_np #(
    .N(N),
    .D(D)
) u_or_mux (
    .i_or(and_results),   
    .o_or(o_mux)          
);

endmodule
