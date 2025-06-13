module cont_ascdesc_3b (
    input clk, updown, reset,
    output reg [2:0] Q
);

always @(posedge clk) begin
    if (reset)
        Q <= 4'b0000;
    else if (updown)
        Q <= Q + 1;
    else 
        Q <= Q - 1;
end

endmodule