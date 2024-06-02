`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2024 12:15:25 PM
// Design Name: 
// Module Name: digit_separator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module digit_separator(
    // Inputs
    mins,
    // Outputs
    mins_10, mins_1
    );
    
    input [5:0] mins;
    output [3:0] mins_10;
    output [3:0] mins_1;
    
    reg [3:0] mins_10_temp;
    reg [3:0] mins_1_temp;
    
    always @ (mins) begin
        mins_10_temp <= mins / 10;
        mins_1_temp <= mins % 10;
    end
    
    assign mins_10 = mins_10_temp;
    assign mins_1 = mins_1_temp;
endmodule
