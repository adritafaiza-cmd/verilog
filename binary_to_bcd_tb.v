`timescale 1ns / 1ps

module binary_to_bcd_tb;

    // Inputs
    reg [3:0] bin;

    // Outputs
    wire [3:0] tens;
    wire [3:0] ones;
    wire valid;

    // Instantiate the Unit Under Test (UUT)
    binary_to_bcd uut (
        .bin(bin), 
        .tens(tens), 
        .ones(ones), 
        .valid(valid)
    );

    integer i;
    integer expected_tens;
    integer expected_ones;
    integer errors;

    initial begin
        // Initialize Inputs
        bin = 0;
        errors = 0;

        $display("Starting Simulation...");
        $display("BIN | TENS | ONES | VALID | STATUS");
        $display("----------------------------------");

        for (i = 0; i < 16; i = i + 1) begin
            bin = i;
            #10; // Wait for combinational logic to settle

            // Calculate expected values for verification
            if (i <= 9) begin
                expected_tens = 0;
                expected_ones = i;
                if (tens !== expected_tens || ones !== expected_ones || valid !== 1'b1) begin
                    $display("%h   | %h    | %h    | %b     | FAIL (Expected %d%d)", bin, tens, ones, valid, expected_tens, expected_ones);
                    errors = errors + 1;
                end else begin
                    $display("%h   | %h    | %h    | %b     | PASS", bin, tens, ones, valid);
                end
            end else begin
                // Per your code logic: if > 9, tens/ones are 0 and valid is 0
                if (tens !== 0 || ones !== 0 || valid !== 1'b0) begin
                    $display("%h   | %h    | %h    | %b     | FAIL (Should be invalid)", bin, tens, ones, valid);
                    errors = errors + 1;
                end else begin
                    $display("%h   | %h    | %h    | %b     | PASS (Invalid as expected)", bin, tens, ones, valid);
                end
            end
        end

        if (errors == 0)
            $display("----------------------------------\\nAll test cases passed!");
        else
            $display("----------------------------------\\nSimulation finished with %d errors.", errors);
            
        $finish;
    end
      
endmodule
'''

with open("binary_to_bcd/binary_to_bcd_tb.v", "w") as f:
    f.write(testbench_code)


print("Testbench binary_to_bcd_tb.v has been created successfully!")
