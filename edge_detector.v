module edge_detector (
    input wire clk,
    input wire rst,
    input wire signal_in,      // señal limpia del botón
    output wire rising_edge    // pulso de 1 ciclo cuando detecta subida
);
    reg prev;

    always @(posedge clk or posedge rst) begin
        if (rst)
            prev <= 0;
        else
            prev <= signal_in;
    end

    assign rising_edge = ~prev & signal_in;  // 1 sólo cuando signal_in cambia de 0 a 1
endmodule