module main (
    input clk, reset, sensor_a, sensor_b, 
    output [2:0] count
);

wire sensor_a_clean, sensor_b_clean, reset_clean, pulse_reset;
wire fsm_in_output, fsm_out_output;

parameter DEB_MAX_COUNT = 1; // 240000 por default, para tb un valor menor

debouncer #(DEB_MAX_COUNT) deb_sensor_a (
    .clk(clk),
    .raw_signal(sensor_a),
    .clean_signal(sensor_a_clean)
);

debouncer #(DEB_MAX_COUNT) deb_sensor_b (
    .clk(clk),
    .raw_signal(sensor_b),
    .clean_signal(sensor_b_clean)
);

debouncer #(DEB_MAX_COUNT) deb_reset (
    .clk(clk),
    .raw_signal(reset),
    .clean_signal(reset_clean)
);

pulse_detector pd_rst (
    .clk(clk),
    .rst(1'b0),
    .signal_in(reset_clean),
    .pulse(pulse_reset)
);

reg [1:0] ab;

always @(sensor_a_clean, sensor_b_clean) begin
    ab <= {~sensor_a_clean, ~sensor_b_clean}; // activo a bajo
    // ab <= {sensor_a_clean, sensor_b_clean}; // activo a alto ->PARA TB<- ?
end

fsm fsm_in_out (
    .clk(clk),
    .reset(pulse_reset),
    .ab(ab),
    .in(fsm_in_output),
    .out(fsm_out_output)
);

contador_3b contador (
    .clk(clk),
    .reset(pulse_reset),
    .enable((fsm_in_output && (count < 3'b111)) || (fsm_out_output && (count > 3'b000))),
    .updown(fsm_in_output), // si entra por fsm_in_output=1 (suma) sino es =0 (resta)
    .count(count)
);

endmodule