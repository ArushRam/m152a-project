`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:56 03/19/2013 
// Design Name: 
// Module Name:    top 
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

module top(
	input wire clk,			//master clock = 100MHz
    input wire btnL,
    input wire btnR,
    input wire btnU,
    input wire btnD,
    input wire placeMarker,
    input wire resetGameSwitch,
    input wire resetMatchSwitch,

	output wire [6:0] seg,	    // 7-segment display LEDs
	output wire [3:0] an,	    // 7-segment display anode enable
	output wire [2:0] red,	    // red vga output - 3 bits
	output wire [2:0] green,    // green vga output - 3 bits
	output wire [2:0] blue,	    // blue vga output - 3 bits
	output wire hsync,		    // horizontal sync out
	output wire vsync,		    // vertical sync out
    ouptut wire player1_turn,   // LED
    output wire player2_turn    // LED
);

    // declare debounced inputs
    wire btnL_d;
    wire btnR_d;
    wire btnU_d;
    wire btnD_d;
    wire placeMarker_d;
    wire resetGameSwitch_d;
    wire resetMatchSwitch_d;

    // 1. Debounce All Input Signals
    debounce_metastabilize btnL_dbc(btn_L, clk, btnL_d);
    debounce_metastabilize btnR_dbc(btn_R, clk, btnR_d);
    debounce_metastabilize btnU_dbc(btn_U, clk, btnU_d);
    debounce_metastabilize btnD_dbc(btn_D, clk, btnD_d);
    debounce_metastabilize enter_dbc(placeMarker, clk, placeMarker_d);
    debounce_metastabilize rst_game_dbc(resetGameSwitch, clk, resetGameSwitch_d);
    debounce_metastabilize rst_match_dbc(resetMatchSwitch, clk, resetMatchSwitch_d);  

    // indicator signals to detect change in switch
    wire resetGame;
    wire resetMatch;
    switch_flip_signal reset_game_flip(resetGameSwitch_d, resetGame);
    switch_flip_signal reset_match_flip(resetMatchSwitch_d, resetMatch);

    // 2. Generate clock signals
    wire clk_vga;
    wire clk_seg;
    clockdiv clock_divider(clk, 0, clk_vga, clk_seg);

    // 3. Match Management
    // declare match variables
    wire lastWinner;        // 0 -> Player 1, 1 -> Player 2
    wire gameFinished;      // indicator to update scores
    match_manager MatchManager(lastWinner, gameFinished, resetMatch, clk_seg, seg, an);

    // 4. Game Management
    // declare game variables
    wire [2:0] game_board [0:4][0:4];
    reg [2:0] cursor_row;
    reg [2:0] cursor_col;

    game_manager GameManager(
        btnL_d, btnR_d, btnU_d, btnD_d, placeMarker_d, resetGame_d,
        game_board, lastWinner, player1_turn, player2_turn, gameFinished, cursor_row, cursor_col
    );

    // 5. VGA Display
    vga_display Display(
        // inputs
        clk_display, game_board, cursor_row, cursor_col,
        // outputs
        hsync, vsync, red, green, blue
    )


endmodule