// handles refresh per basys 3 manual

module display(
  // inputs
  input clk_250Hz,
  input [3:0] ones,
  input [3:0] tens,
  input [3:0] hundreds,
  input [3:0] thousands,
  output reg [6:0] seg, // cathodes pattern
  output reg [3:0] digit
);
  parameter ZERO = 7'b1000000;
  parameter ONE = 7'b1111001;
  parameter TWO = 7'b0100100;
  parameter THREE = 7'b0110000;
  parameter FOUR = 7'b0011001;
  parameter FIVE = 7'b0010010;
  parameter SIX = 7'b0000010;
  parameter SEVEN = 7'b1111000;
  parameter EIGHT = 7'b0000000;
  parameter NINE = 7'b0010000;
  parameter OFF = 7'b1111111;
  reg [1:0] display_digit;

  // light up D1 -> D2 -> D3 -> D4 for 4ms each for smooth visual
  always @(posedge clk_250Hz) begin
    display_digit <= display_digit + 1;
  end

  // display_digit = 2'b00 refers to the ones digit to 2'b11 refers to the thousands digit
  always @(display_digit) begin
    case (display_digit)
      2'b00 : digit = 4'b1110;
      2'b01 : digit = 4'b1101;
      2'b10 : digit = 4'b1011;
      2'b11 : digit = 4'b0111;
    endcase
  end

  // Logic for driving segments based on which digit is selected and the value of each digit
  always @*  begin
    case(display_digit)
      2'b00 : begin       // ONES DIGIT
        case(ones)
            4'b0000 : seg = ZERO;
            4'b0001 : seg = ONE;
            4'b0010 : seg = TWO;
            4'b0011 : seg = THREE;
            4'b0100 : seg = FOUR;
            4'b0101 : seg = FIVE;
            4'b0110 : seg = SIX;
            4'b0111 : seg = SEVEN;
            4'b1000 : seg = EIGHT;
            4'b1001 : seg = NINE;
        endcase
      end       
      2'b01 : begin       // TENS DIGIT
        case(tens)
            4'b0000 : seg = ZERO;
            4'b0001 : seg = ONE;
            4'b0010 : seg = TWO;
            4'b0011 : seg = THREE;
            4'b0100 : seg = FOUR;
            4'b0101 : seg = FIVE;
            4'b0110 : seg = SIX;
            4'b0111 : seg = SEVEN;
            4'b1000 : seg = EIGHT;
            4'b1001 : seg = NINE;
        endcase
      end     
      2'b10 : begin       // HUNDREDS DIGIT
        case(hundreds)
            4'b0000 : seg = ZERO;
            4'b0001 : seg = ONE;
            4'b0010 : seg = TWO;
            4'b0011 : seg = THREE;
            4'b0100 : seg = FOUR;
            4'b0101 : seg = FIVE;
            4'b0110 : seg = SIX;
            4'b0111 : seg = SEVEN;
            4'b1000 : seg = EIGHT;
            4'b1001 : seg = NINE;
        endcase
      end          
      2'b11 : begin       // MINUTES ONES DIGIT
        case(thousands)
            4'b0000 : seg = ZERO;
            4'b0001 : seg = ONE;
            4'b0010 : seg = TWO;
            4'b0011 : seg = THREE;
            4'b0100 : seg = FOUR;
            4'b0101 : seg = FIVE;
            4'b0110 : seg = SIX;
            4'b0111 : seg = SEVEN;
            4'b1000 : seg = EIGHT;
            4'b1001 : seg = NINE;
        endcase
      end
    endcase
  end
endmodule