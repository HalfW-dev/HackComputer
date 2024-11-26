`include "./gates/mux_np.sv"
`include "./gates/demux_np.sv"

module ram_nb #(
    parameter N = 16384,
    parameter D = 16
) (
    input clk_i,
    input rst_ni,

    input logic [D-1:0] i_in,
    input logic [$clog2(N)-1:0] i_addr,

    input logic i_load,

    output logic [D-1:0] o_out
);

endmodule