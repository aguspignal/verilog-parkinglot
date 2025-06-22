module debouncer (
    input wire clk, raw_signal, // señal del btn
    output reg clean_signal
);
    reg [17:0] count;
    reg signal_copy; // copia de la señal del btn para detectar cambios

    always @(posedge clk) begin
        signal_copy <= raw_signal;

        if (signal_copy != raw_signal) // la señal del btn cambio, estabilizamos devuelta
            count <= 0;
        else begin
            if (count < 240000)
            // if (count < 0) // <--- para simulacion en testbench, no necesitamos debouncer
                count <= count + 1; // mientras la señal se estabiliza
            else 
                clean_signal <= raw_signal; // despues de mantenerse estable suficiente tiempo
        end
    end
endmodule