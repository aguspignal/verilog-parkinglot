module fsm (
    input clk, reset,
    input [1:0] ab,
    output y, z 
    // output [1:0] yz
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

always @(state or ab) begin
    case (state)
        S0: if (ab == 2'b10)
                next_state = S1;
            else if (ab == 2'b01)
                next_state = S2;
            else
                next_state = S0;

        S1: if (ab == 2'b11)
                next_state = S3;
            else if (ab == 2'b00)
                next_state = S0;
            else
                next_state = S1;

        S2: if (ab == 2'b11)
                next_state = S4;
            else if (ab == 2'b00)
                next_state = S0;
            else
                next_state = S2;

    
         S3: if (ab == 2'b01)
                next_state = S5;
            else if (ab == 2'b10)
                next_state = S1;
            else
                next_state = S3;

        S4: if (ab == 2'b10)
                next_state = S6;
            else if (ab == 2'b01)
                next_state = S2;
            else
                next_state = S4;

        S5: if (ab == 2'b00)
                next_state = S0;
            else if (ab == 2'b11)
                next_state = S3;
            else
                next_state = S5;

        S6: if (ab == 2'b00)
                next_state = S0;
            else if (ab == 2'b11)
                next_state = S4;
            else
                next_state = S6;
        default: next_state = state;
    endcase
end




assign y = ((state == S5) & ab == 2'b00); // entró un auto
assign z = ((state == S6) & ab == 2'b00); // salió un auto
// assign yz = {((state == S5) & ab = 2'b00), ((state == S6) & ab = 2'b00)};

endmodule