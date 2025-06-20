module contador_3b (
    input clk, updown, reset, enable,
    output reg [2:0] count
);

always @(posedge clk) begin
    if (reset)
        count <= 3'b000;
    else if (enable) begin
        if (updown)
            if (count < 3'b111) count <= count + 1;
        else 
            if (count > 3'b000) count <= count - 1;
    end
end

endmodule