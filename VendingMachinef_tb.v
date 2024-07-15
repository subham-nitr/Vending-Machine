
`include "VendingMachinef.v"
module VendingMachinef_tb;

 //inputs
reg clk;
reg[1:0] in;
reg rst;
//output
wire[1:0] out;
wire[1:0] change;
wire[2:0] state_led;
VendingMachinef uut(
.clk(clk),
.rst(rst),
.in(in),
.out(out),
.change(change),
.state_led(state_led)
);

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    // Test sequence
    initial begin
    $dumpfile("VendingMachinef.vcd");
    $dumpvars(0,VendingMachinef_tb);
        // Initialize Inputs
        rst = 1;
        in = 2'b00;

        // Wait for global reset to finish
        #20;
        rst = 0;

        // Insert 5 rs
        #10;
        in = 2'b01;
        
        // Insert 10 rs
        #10;
        in = 2'b10;
        

        // Insert invalid coin
        #10;
        in = 2'b11;
       
        // Insert 5 rs, then 10 rs for special item
        #10;
        in = 2'b01;

        #10;
        in = 2'b10;
       
        // Insert 10 rs, then 10 rs to check change
        #10;
        in = 2'b10;
        
        #10;
        in = 2'b10;

        // Reset the machine
        #10;
        rst = 1;
        #10;
        rst = 0;
        
        // End of simulation
        #50;
        $finish;
    end
      
endmodule
