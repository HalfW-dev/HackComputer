`include "./full_adder_nb.sv"  

module parallel_adder_nb #(
    parameter N = 16  
)(
    input  logic [N-1:0] i_op_a,       
    input  logic [N-1:0] i_op_b,       
    input  logic        i_carry_in,   

    output logic [N-1:0] o_sum,        
    output logic        o_carry_out    
);

wire [N:0] carry;  // Internal carry chain


assign carry[0] = i_carry_in;

genvar i;
generate
    for (i = 0; i < N; i = i + 1) begin : full_adder_chain
        fulladder #(.D(1)) fa (
            .i_op_a(i_op_a[i]),      
            .i_op_b(i_op_b[i]),      
            .i_carry_in(carry[i]),   
            .o_sum(o_sum[i]),        
            .o_carry_out(carry[i+1]) 
        );

    end
endgenerate

// Final carry-out from the most significant bit (MSB)
assign o_carry_out = carry[N];

endmodule
