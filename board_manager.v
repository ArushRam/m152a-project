`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:56 03/19/2013 
// Design Name: 
// Module Name:    board_manager 
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

module board_manager(
    input wire resetGame,
    input wire playerId,
    input wire placeMarker,
    input wire [2:0] selectedRow,
    input wire [2:0] selectedCol,
    output wire [1:0] game_board [0:4][0:4],
);

    reg [1:0] cur_board [0:4][0:4];

    initial begin
        // TODO: set board to all 0s initially
    end

    always @(*) begin

        // TODO: set board to all 0s if resetGame
        // TODO: if placeMarker is high, then set game_board[row][col] to playerId

    end

    assign game_board = cur_board;

endmodule