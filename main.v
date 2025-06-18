`include "cont_ascdesc_3b/cont_ascdesc_3b.v"

module main (
    input clk, a, b, reset,
    output [2:0] count
);

wire btn_add_clean, btn_sub_clean, rst_clean;
wire pulse_add, pulse_sub, pulse_rst;
wire fsm_in_output, fsm_out_output, fsm_output;

debouncer deb_add (
    .clk(clk),
    .rst(1'b0),
    .noisy(a),
    .clean(btn_add_clean)
);

debouncer deb_sub (
    .clk(clk),
    .rst(1'b0),
    .noisy(b),
    .clean(btn_sub_clean)
);

reg [1:0] value;

always @(btn_add_clean, btn_sub_clean) begin
    value <= {~btn_add_clean, ~btn_sub_clean};
end

debouncer deb_rst (
    .clk(clk),
    .rst(1'b0),
    .noisy(reset),
    .clean(rst_clean)
);

edge_detector ed_rst (
    .clk(clk),
    .rst(1'b0),
    .signal_in(rst_clean),
    .rising_edge(pulse_rst)
);

fsm_in fsm_entrada_vehiculo (
    .clk(clk),
    .ab(value),
    .reset(pulse_rst | (count >= 3'b111)),
    .y(fsm_in_output)
);

fsm_out fsm_salida_vehiculo (
    .clk(clk),
    .ab(value),
    .reset(pulse_rst | (count == 3'b000)),
    .y(fsm_out_output)
);

cont_ascdesc_3b contador (
    .clk(clk),
    .enable(fsm_in_output | fsm_out_output | pulse_rst),
    .updown(fsm_in_output),
    .reset(pulse_rst),
    .Q(count)
);

endmodule