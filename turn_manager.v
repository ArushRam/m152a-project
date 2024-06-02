`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:56 03/19/2013 
// Design Name: 
// Module Name:    turn_manager 
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

module turn_manager(
    input wire placeMarker,
    input wire resetGame,
    input wire lastWinner,
    output wire [1:0] nextPlayer,
);

    reg [1:0] currentPlayer;

    initial begin
        // set to player 1 initially
        currentPlayer <= 0b'01;
    end

    always @(*) begin
        if (resetGame) begin
            // set current player to last loser if game is reset
            if (lastWinner == 0) begin
                currentPlayer <= 0b'10;
            end
            else begin
                currentPlayer <= 0b'01;
            end
        end
        else if (placeMarker) begin
            // bitwise flip current player if marker is placed
            currentPlayer <= ~currentPlayer;
        end
    end

    assign nextPlayer = currentPlayer;

endmodule