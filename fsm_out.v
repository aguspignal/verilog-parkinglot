module fsm_out (
    input clk, reset,
    input [1:0] ab,
    output y
);

localparam [1:0]
    S0 = 2'b00, // ambos sensores activos
    S1 = 2'b01, // se corta sensor b
    S2 = 2'b11, // se cortan ambos
    S3 = 2'b10; // se reactiva sensor b

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

always @(state or ab) begin
    case (state)
        S0: if (ab == 2'b01) // empieza por sensor b (salida)
                next_state = S1;
            else
                next_state = S0;

        S1: if (ab == 2'b11) // pasa por ambos sensores
                next_state = S2;
            else if (ab == 2'b00) // hace marcha atras
                next_state = S0;
            else
                next_state = S1;

        S2: if (ab == 2'b10) // avanza
                next_state = S3;
            else if (ab == 2'b01) // hace marcha atras
                next_state = S1;
            else 
                next_state = S2;

        S3: if (ab == ~state) // no deberia suceder
                next_state = state;
            else if (ab == 2'b00) // salio del estacionamiento
                next_state = S0;
            else
                next_state = ab;
    endcase
end

assign y = ((state == S3) & (ab == 2'b00));

endmodule