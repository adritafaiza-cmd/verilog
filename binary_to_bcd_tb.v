`timescale 1ns/1ps

module binary_to_bcd_tb;

  reg  [3:0] binary_input;
  wire [3:0] tens;
  wire [3:0] ones;
  wire       valid;

  // DUT
  binary_to_bcd uut (
    .binary_input(binary_input),
    .tens(tens),
    .ones(ones),
    .valid(valid)
  );

  integer i;
  reg [3:0] exp_tens;
  reg [3:0] exp_ones;

  task check;
    input [3:0] in;
    begin
      binary_input = in;
      #1; // allow combinational settle

      if (in <= 4'd9) begin
        exp_tens = 4'd0;
        exp_ones = in;
      end else begin
        exp_tens = 4'd1;
        exp_ones = in - 4'd10;
      end

      // Check valid always 1
      if (valid !== 1'b1) begin
        $display("FAIL: in=%0d valid=%b (expected 1)", in, valid);
        $stop;
      end

      // Check tens/ones
      if (tens !== exp_tens || ones !== exp_ones) begin
        $display("FAIL: in=%0d tens=%0d ones=%0d (expected tens=%0d ones=%0d)",
                 in, tens, ones, exp_tens, exp_ones);
        $stop;
      end else begin
        $display("PASS: in=%0d -> tens=%0d ones=%0d valid=%b",
                 in, tens, ones, valid);
      end
    end
  endtask

  initial begin
    $display("=== binary_to_bcd TB start ===");

    // Test all inputs 0..15
    for (i = 0; i < 16; i = i + 1) begin
      check(i[3:0]);
    end

    $display("=== ALL TESTS PASSED ===");
    $finish;
  end

endmodule
