`timescale 1ns / 1ps

module binary_to_bcd_tb;

    // Inputs
    reg [3:0] bin;

    // Outputs
    wire [3:0] tens;
    wire [3:0] ones;
    wire valid;

    // Instantiate the Unit Under Test (UUT)
    // We are connecting to a module named 'binary_to_bcd'
    binary_to_bcd uut (
        .bin(bin), 
        .tens(tens), 
        .ones(ones), 
        .valid(valid)
    );

    integer i;
    
    initial begin
        // Initialize Inputs
        bin = 0;

        $display("Starting Simulation...");
        $display("BIN | TENS | ONES | VALID");
        $display("-------------------------");

        for (i = 0; i < 16; i = i + 1) begin
            bin = i;
            #10; // Wait for logic to settle
            $display("%d   | %d    | %d    | %b", bin, tens, ones, valid);
        end
        
        $display("-------------------------");
        $finish;
    end
      
endmodule
