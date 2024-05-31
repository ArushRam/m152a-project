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

module box_selector(
    input wire btnL,
    input wire btnR,
    input wire btnU,
    input wire btnD,
    output wire [2:0] box_row,
    output wire [2:0] box_col
);

    reg [2:0] cur_box_row;
    reg [2:0] cur_box_col;

    // TODO: Implement navigation on 5x5 grid
    // btnL, btnR, btnU, btnD are movement inputs
    // box_row, box_col indicate current selected box
    // generate next coordinates based on current coordinates + direction

endmodule