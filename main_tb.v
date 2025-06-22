`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module main_tb();

reg clk = 0;
always #0.5 clk = ~clk;

reg a, b, reset;
wire [2:0] count;

main uut (
    .clk(clk),
    .sensor_a(a),
    .sensor_b(b),
    .reset(reset),
    .count(count)
);

initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, main_tb);
    
    reset = 1;
    a = 1; b = 1; // simulo el activo a bajo
    #1
    reset = 0;
    a = 0; b = 1;
    #2
    a = 0; b = 0;
    #2
    a = 1; b = 0;
    #2
    a = 1; b = 1;
    #2
    a = 0; b = 1;
    #2
    a = 0; b = 0;
    #2
    a = 1; b = 0;
    #2
    a = 1; b = 1;
    #2

    $finish;
end
endmodule