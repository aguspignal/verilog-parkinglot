module pulse_detector (
    input wire clk, rst, signal_in, // señal limpia del debouncer
    output wire pulse
);
    reg prev;

    always @(posedge clk or posedge rst) begin
        if (rst)
            prev <= 0;
        else
            prev <= signal_in;
    end

    // si la señal pasa de 0 a 1 tenemos flanco positivo
    assign pulse = ~prev & signal_in;

    // para simulacion en testbench, con entradas activas a alto 
    // assign pulse = prev & ~signal_in;
endmodule