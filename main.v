`include "cont_ascdesc_3b/cont_ascdesc_3b.v"

module main (
    input clk, a, b, reset,
    output [2:0] count
);

wire fsm_in_output, fsm_out_output, fsm_output;

fsm_in fsm_entrada_vehiculo (
    .clk(clk),
    .a(a),
    .b(b),
    .reset(reset | (count >= 3'b111)),
    .y(fsm_in_output)
);

fsm_out fsm_salida_vehiculo (
    .clk(clk),
    .a(a),
    .b(b),
    .reset(reset | (count == 3'b000)),
    .y(fsm_out_output)
);

// fsm fsm_ (
//     .clk(clk)
//     .a(a),
//     .b(b),
//     .reset(reset | (count == 3'b111)),
//     .y(fsm_output)
// )

cont_ascdesc_3b contador (
    .clk(fsm_in_output | fsm_out_output | reset),
    .updown(fsm_in_output),
    .reset(reset),
    .Q(count)
);

endmodule