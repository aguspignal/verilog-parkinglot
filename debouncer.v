module debouncer (
    input wire clk,     // reloj del sistema (ej. 12 MHz)
    input wire rst,     // señal de reset (activa en alto)
    input wire noisy,   // señal del botón, posiblemente con rebotes
    output reg clean    // salida estable: solo cambia si la entrada fue estable mucho tiempo
);
    reg [17:0] count;   // contador de estabilidad (suficiente para contar hasta 262144 ciclos)
    reg sync;           // copia temporal de la señal de entrada, para detectar cambios

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            clean <= 0;
            sync <= 0;
        end else begin
            sync <= noisy;  // actualizamos la copia de la señal actual

            if (sync == noisy) begin
                // Si la señal se mantiene estable (sin cambios) aumentamos el contador
                if (count < 240000)
                    count <= count + 1;  // seguimos contando estabilidad
                else
                    clean <= noisy;     // después de suficiente tiempo, actualizamos salida limpia
            end else
                count <= 0;  // si la señal cambia, reiniciamos el contador para empezar a medir de nuevo
        
        end
    end
endmodule