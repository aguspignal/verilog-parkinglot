`include "cont_ascdesc_3b/cont_ascdesc_3b.v"

module main (
    input clk, sensor_a, sensor_b, reset,
    output [2:0] count
);

wire sensor_a_clean, sensor_b_clean, rst_clean, pulse_rst;
wire fsm_in_output, fsm_out_output;

debouncer deb_add (
    .clk(clk),
    .noisy(sensor_a),
    .clean(sensor_a_clean)
);

debouncer deb_sub (
    .clk(clk),
    .noisy(sensor_b),
    .clean(sensor_b_clean)
);

debouncer deb_rst (
    .clk(clk),
    .noisy(reset),
    .clean(rst_clean)
);

edge_detector ed_rst (
    .clk(clk),
    .rst(1'b0),
    .signal_in(rst_clean),
    .rising_edge(pulse_rst)
);

reg [1:0] ab;

always @(sensor_a_clean, sensor_b_clean) begin
    ab <= {~sensor_a_clean, ~sensor_b_clean};
end

fsm_in fsm_entrada_vehiculo (
    .clk(clk),
    .ab(ab),
    .reset(pulse_rst | (count >= 3'b111)),
    .y(fsm_in_output)
);

fsm_out fsm_salida_vehiculo (
    .clk(clk),
    .ab(ab),
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