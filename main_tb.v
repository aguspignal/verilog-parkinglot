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
    a = 0; b = 0; // si simulamos activas a bajo probar a=b=1;
    #2 // entra un auto
    reset = 0;
    #3
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1
    a = 0; b = 0;
    #1 // entra otro
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1
    a = 0; b = 0;
    #1 // entra otro
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1 
    a = 0; b = 0;
    #2 // sale un auto
    a = 0; b = 1;
    #1 
    a = 1; b = 1;
    #1
    a = 1; b = 0;
    #1
    a = 0; b = 0;
    #3

    $finish;
end
endmodule