module fsm_out (
    input clk, a, b, reset,
    output reg y
);

localparam [1:0]
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b11,
    S3 = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state = S0;
    end 
    else begin
        state = next_state;
    end
end

always @(state or a or b) begin
    case (state)
        S0: 
            begin
                y = 0;
                if (~a & b)
                    next_state = S1;
                else
                    next_state = S0;
            end

        S3: 
            if ({a, b} == ~state)
                next_state = state;
            else if (~a & ~b) 
                begin
                    next_state = S0;
                    y = 1;
                end
            else 
                begin
                    next_state = {a, b};
                    y = 0;
                end

        default: 
            begin
                y = 0;
                if ({a, b} == ~state)
                    next_state = state;
                else 
                    next_state = {a, b};
            end
    endcase
end

endmodule