module fsm_out (
    input clk, reset,
    input [1:0] ab,
    output y
);

localparam [1:0]
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b11,
    S3 = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

always @(state or ab) begin
    case (state)
        S0: if (ab == 2'b01)
                next_state = S1;
            else
                next_state = S0;

        S1: if (ab == 2'b11)
                next_state = S2;
            else if (ab == 2'b00)
                next_state = S0;
            else
                next_state = S1;

        S2: if (ab == 2'b10)
                next_state = S3;
            else if (ab == 2'b01)
                next_state = S1;
            else 
                next_state = S2;

        S3: if (ab == ~state)
                next_state = state;
            else if (ab == 2'b00)
                next_state = S0;
            else
                next_state = ab;
    endcase
end

assign y = ((state == S3) & (ab == 2'b00));

endmodule