`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:56 03/19/2013 
// Design Name: 
// Module Name:    match_manager 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module match_manager(
    input wire lastWinner,      // indicator of which player won the last game
    input wire resetMatch,      // reset scores AND game
    input wire clk_seg,         // 7-segment display clock
	output wire [6:0] seg,	    // 7-segment display LEDs
	output wire [3:0] an,	    // 7-segment display anode enable
);

reg [6:0] player1_score;
reg [6:0] player2_score;

initial begin
    player1_score <= 0;
    player2_score <= 0;
end

// TODO: Initialize 7-segment display accepting scores, pass in player1_score and player2_score
// maybe move the logic from digit_separator to our previous display file

always @(*) begin
    if (resetMatch) begin
        player1_score <= 0;
        player2_score <= 0;  
    end
    else begin
        if (gameFinished && lastWinner == 0) begin
            player1_score <= player1_score + 1;
        end
        else if (gameFinished && lastWinner == 1) begin
            player2_score <= player2_score + 1;
        end
    end
end

endmodule