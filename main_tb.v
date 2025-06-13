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
    .a(a),
    .b(b),
    .reset(reset),
    .count(count)
);

initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, main_tb);
    
    a = 0; b = 0; reset = 1;
    #1
    a = 0; b = 1; reset = 0;
    #1
    a = 0; b = 0;

    #1 // aca deberia avanzar
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1 // aca deberia retroceder
    a = 1; b = 0;
    #1 
    a = 1; b = 1;
    #1 // deberia mantener estado
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1 // deberia ir al inicio con salida 1
    a = 0; b = 0;
    
    #1 // meto otro auto
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1
    a = 0; b = 0;

    #1 // saco un auto
    a = 0; b = 1;
    #1
    a = 1; b = 1;
    #1
    a = 1; b = 0;
    #1 // saco otro
    a = 0; b = 0;
    #1
    a = 0; b = 1;
    #1
    a = 1; b = 1;
    #1
    a = 1; b = 0;
    #1
    a = 0; b = 0;
    #1 // este no deberia salir (pq no hay)
    a = 0; b = 0;
    #1
    a = 0; b = 1;
    #1
    a = 1; b = 1;
    #1
    a = 1; b = 0;
    #1
    a = 0; b = 0;

    #1 // meto un auto
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1
    a = 0; b = 0;
    #1 // meto 2do auto
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1
    a = 0; b = 0;
    #1 // meto 3er auto
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1
    a = 0; b = 0;
    #1 // meto 4to auto
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1
    a = 0; b = 0;
    #1 // meto 5to auto
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1
    a = 0; b = 0;
    #1 // meto 6to auto
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1
    a = 0; b = 0;
    #1 // meto 7to auto
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1
    a = 0; b = 0;
    #1 // este no deberia entrar
    a = 1; b = 0;
    #1
    a = 1; b = 1;
    #1
    a = 0; b = 1;
    #1
    a = 0; b = 0;
    $finish;
end
endmodule