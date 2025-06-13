`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module cont_ascdesc_3b_tb();

reg clk = 0;
always #0.5 clk = ~clk;

reg ud, rst;
wire [2:0] Q;

cont_ascdesc_3b uut (
    .clk(clk),
    .updown(ud),
    .reset(rst),
    .Q(Q)
);

initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, cont_ascdesc_3b_tb);
    
    ud = 1; rst = 1;
    #1
    rst = 0; 
    #10
    ud = 0;
    #10
    
    $finish;
end
endmodule