module fsm_out (
    input clk, a, b, reset,
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

always @(state or a or b) begin
    case (state)
        S0: if (~a & b)
                    next_state = S1;
                else
                    next_state = S0;

        S3: if ({a, b} == ~state)
                next_state = state;
            else if (~a & ~b) 
                next_state = S0;
            else 
                next_state = {a, b};

        default: 
            if ({a, b} == ~state)
                next_state = state;
            else 
                next_state = {a, b};
    endcase
end

assign y = (state[1] & ~state[0] & ~a & ~b);

endmodule