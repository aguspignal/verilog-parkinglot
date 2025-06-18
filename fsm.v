module fsm (
    input clk, a, b, reset,
    output y
);
    
localparam [2:0]
    S0 = 3'b000,
    S1 = 3'b001,
    S2 = 3'b010,
    S3 = 3'b011,
    S4 = 3'b100,
    S5 = 3'b101,
    S6 = 3'b110;

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= S0;
    else
        state <= next_state; 
end

always @(state or a or b) begin
    case (state)
        S0: if (a & ~b) // 10
                next_state = S1;
            else if (~a & b) // 01
                next_state = S2;
            else
                next_state = S0;

        S1: if (~a & ~b) // 00
                next_state = S0;
            else if (a & b) // 11
                next_state = S3;
            else
                next_state = S1;

        S2: if (~a & ~b) // 00
                next_state = S0;
            else if (a & b) // 11
                next_state = S4;
            else
                next_state = S2;

        S3: if (a & ~b) // 10
                next_state = S1;
            else if (~a & b) // 01
                next_state = S5;
            else
                next_state = S3;

        S4: if (~a & b) // 01
                next_state = S2;
            else if (a & ~b) // 10
                next_state = S6;
            else
                next_state = S4;

        S5: if (a & b) // 11
                next_state = S3;
            else if (~a & ~b) // 00
                next_state = S0;
            else
                next_state = S5;

        S6: if (a & b) // 11
                next_state = S4;
            else if (~a & ~b) // 00
                next_state = S0;
            else
                next_state = S6;
    endcase
end

assign y = (((state == S5) | (state == S6)) & ~a & ~b);

endmodule