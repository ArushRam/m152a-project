`timescale 1ns / 1ps

module win_checker(
    input wire [49:0] board_bit, // Your 50-bit number
    input wire [1:0] player_id,
    output wire player_won
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
        win = 0;
        // Check rows and columns
        for (i = 0; i < 5; i = i + 1) begin
            if (board[i][0] == player_id && board[i][1] == player_id && board[i][2] == player_id && board[i][3] == player_id) begin
                win = 1;
            end
            if (board[i][1] == player_id && board[i][2] == player_id && board[i][3] == player_id && board[i][4] == player_id) begin
                win = 1;
            end
            if (board[0][i] == player_id && board[1][i] == player_id && board[2][i] == player_id && board[3][i] == player_id) begin
                win = 1;
            end
            if (board[1][i] == player_id && board[2][i] == player_id && board[3][i] == player_id && board[4][i] == player_id) begin
                win = 1;
            end
        end

        // Check diagonals
        if (board[0][0] == player_id && board[1][1] == player_id && board[2][2] == player_id && board[3][3] == player_id) begin
            win = 1;
        end
        if (board[1][1] == player_id && board[2][2] == player_id && board[3][3] == player_id && board[4][4] == player_id) begin
            win = 1;
        end
        if (board[0][1] == player_id && board[1][2] == player_id && board[2][3] == player_id && board[3][4] == player_id) begin
            win = 1;
        end
        if (board[1][0] == player_id && board[2][1] == player_id && board[3][2] == player_id && board[4][3] == player_id) begin
            win = 1;
        end
        if (board[4][0] == player_id && board[3][1] == player_id && board[2][2] == player_id && board[1][3] == player_id) begin
            win = 1;
        end
        if (board[3][1] == player_id && board[2][2] == player_id && board[1][3] == player_id && board[0][4] == player_id) begin
            win = 1;
        end
        if (board[3][0] == player_id && board[2][1] == player_id && board[1][2] == player_id && board[0][3] == player_id) begin
            win = 1;
        end
        if (board[4][1] == player_id && board[3][2] == player_id && board[2][3] == player_id && board[1][4] == player_id) begin
            win = 1;
        end
    end

    assign player_won = win;
endmodule
