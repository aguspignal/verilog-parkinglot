module contador_3b (
    input clk, updown, reset, enable,
    output reg [2:0] count
);

always @(posedge clk) begin
    if (reset)
        count <= 4'b0000;
    else if (enable) begin
        if (updown)
            count <= count + 1;
        else 
            count <= count - 1;
    end
end

endmodule