module main (
    input clk, reset, sensor_a, sensor_b, 
    output [2:0] count
);

wire sensor_a_clean, sensor_b_clean, reset_clean, pulse_reset;
wire fsm_in_output, fsm_out_output;
// wire [1:0] fsm_output;

debouncer deb_sensor_a (
    .clk(clk),
    .raw_signal(sensor_a),
    .clean(sensor_a_clean)
);

debouncer deb_sensor_b (
    .clk(clk),
    .raw_signal(sensor_b),
    .clean(sensor_b_clean)
);

debouncer deb_reset (
    .clk(clk),
    .raw_signal(reset),
    .clean(reset_clean)
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
end

fsm fsm_in_out (
    .clk(clk),
    .reset(pulse_reset),
    .ab(ab),
    .y(fsm_in_output),
    .z(fsm_out_output)
    // .yz(fsm_output)
);

contador_3b contador (
    .clk(clk),
    .reset(pulse_reset),
    .enable(fsm_in_output | fsm_out_output | pulse_reset),
    .updown(fsm_in_output), // si entra por fsm_in_output=1 (suma) sino es =0  (resta)
    // .enable(fsm_output | pulse_reset),
    // .updown(yz[0]), 
    .count(count)
);

/*
    ==========================
    ROMPER EN CASO DE INCENDIO
    ==========================
*/
// fsm_in fsm_entrada_vehiculo (
//     .clk(clk),
//     .ab(ab),
//     .reset(pulse_reset | (count >= 3'b111)),
//     .y(fsm_in_output)
// );

// fsm_out fsm_salida_vehiculo (
//     .clk(clk),
//     .ab(ab),
//     .reset(pulse_reset | (count == 3'b000)),
//     .y(fsm_out_output)
// );

// contador_3b contador (
//     .clk(clk),
//     .enable(fsm_in_output | fsm_out_output | pulse_reset),
//     .updown(fsm_in_output),
//     .reset(pulse_reset),
//     .count(count)
// );

endmodule