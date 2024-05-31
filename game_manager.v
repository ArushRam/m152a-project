`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:56 03/19/2013 
// Design Name: 
// Module Name:    game_manager 
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

module game_manager(
    input wire btnL, input wire btnR, input wire btnU, input wire btnD,
    input wire placeMarker,
    input wire resetGame,

    output wire [2:0] game_board [0:4][0:4],
    output wire lastWinner,
    output wire player1_turn,
    output wire player2_turn,
    output wire curPlayerWon,
    output wire [2:0] cursor_row,
    output wire [2:0] cursor_col
);

    reg [2:0] cur_game_board [0:4][0:4]

    // TODO: manage player turn
    // store current turn in 2-bit register
    // set indicator LEDs (player1_turn, player2_turn)
    // use placeMarker to flip turns
    reg [1:0] currentPlayer;

    // Manage box selection
    box_selector selected_box(btnL, btnR, btnU, btnD, cursor_row, cursor_col);

    // TODO: If placeMarker is 1, update game board at selected row, col

    // Check if current player has won
    win_checker check_win(cur_game_board, player_id, curPlayerWon);

    // TODO: update lastWinner based on who won the game, if game did finish (indicated by curPlayerWon)

    // TODO: if game finished and user presses placeMarker, reset game and set curPlayerWon to 0
    // TODO: if resetGame pressed, reset game and set curPlayerWon to 0


endmodule