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

    output wire [1:0] game_board [0:4][0:4],
    output wire lastWinner,
    output wire player1_turn,
    output wire player2_turn,
    output wire curPlayerWon,
    output wire [2:0] cursor_row,
    output wire [2:0] cursor_col
);
    
    wire [1:0] currentPlayer;
    turn_manager manage_turns(placeMarker, resetGame, lastWinner, currentPlayer);

    // Manage box selection
    box_selector selected_box(btnL, btnR, btnU, btnD, cursor_row, cursor_col);

    // TODO: If placeMarker is 1, update game board at selected row, col
    board_manager manage_board(resetGame, currentPlayer, placeMarker, cursor_row, cursor_col, game_board);

    // Check if current player has won
    win_checker check_win(game_board, currentPlayer, curPlayerWon);

    // update last winner if game ended
    reg lastWinner_reg;
    always @(curPlayerWon) begin
        if (currentPlayer == b'01) begin
            lastWinner_reg <= 0;
        end else if (currentPlayer == b'10) begin
            lastWinner_reg <= 1;
        end
    end
    assign lastWinner = lastWinner_reg;

endmodule