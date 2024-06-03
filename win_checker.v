`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:56 03/19/2013 
// Design Name: 
// Module Name:    win_checker 
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

module win_checker(
    input wire [49:0] board_bit; // Your 50-bit number
    input wire [1:0] player_id,
    output wire player_won,
);
    reg win;
    integer i, j;
    reg [1:0] board [4:0][4:0]; 

    initial begin
        win = 0;
        for (i = 0; i < 5; i = i + 1) begin
            for (j = 0; j < 5; j = j + 1) begin
                board[i][j] = board_bit[i*10 + j*2 +: 2];
            end
        end
    end

    // Given player value and game board, determine if that player has won the game
    always @(*) begin
        // Check rows and columns
        for (i = 0; i < 5; i = i + 1) begin
            if (board[i][0] == PLAYER_ID && board[i][1] == PLAYER_ID && board[i][2] == PLAYER_ID && board[i][3] == PLAYER_ID) begin
                win = 1;
            end
            if (board[i][1] == PLAYER_ID && board[i][2] == PLAYER_ID && board[i][3] == PLAYER_ID && board[i][4] == PLAYER_ID) begin
                win = 1;
            end
            if (board[0][i] == PLAYER_ID && board[1][i] == PLAYER_ID && board[2][i] == PLAYER_ID && board[3][i] == PLAYER_ID) begin
                win = 1;
            end
            if (board[1][i] == PLAYER_ID && board[2][i] == PLAYER_ID && board[3][i] == PLAYER_ID && board[4][i] == PLAYER_ID) begin
                win = 1;
            end
        end

        // Check diagonals
        if (board[0][0] == PLAYER_ID && board[1][1] == PLAYER_ID && board[2][2] == PLAYER_ID && board[3][3] == PLAYER_ID) begin
            win = 1;
        end
        if (board[1][1] == PLAYER_ID && board[2][2] == PLAYER_ID && board[3][3] == PLAYER_ID && board[4][4] == PLAYER_ID) begin
            win = 1;
        end
        if (board[0][1] == PLAYER_ID && board[1, 2] == PLAYER_ID && board[2][3] == PLAYER_ID && board[3][4] == PLAYER_ID) begin
            win = 1;
        end
        if (board[1][0] == PLAYER_ID && board[2][1] == PLAYER_ID && board[3][2] == PLAYER_ID && board[4][3] == PLAYER_ID) begin
            win = 1;
        end
    end

    assign player_won = win;
endmodule
