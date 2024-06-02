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

    initial begin
        cur_box_row <= 0;
        cur_box_col <= 0;
    end

    always @(*) begin
        if (btnL) begin
            if (cur_box_col == 0) begin
                cur_box_col <= 4;
            end else begin
                cur_box_col <= cur_box_col - 1;
            end
        end
        else if (btnR) begin
            if (cur_box_col == 4) begin
                cur_box_col <= 0;
            end else begin
                cur_box_col <= cur_box_col + 1;
            end
        end
        else if (btnU) begin
            if (cur_box_row == 0) begin
                cur_box_row <= 4;
            end else begin
                cur_box_row <= cur_box_row - 1;
            end
        end
        else if (btnD) begin
            if (cur_box_row == 4) begin
                cur_box_row <= 0;
            end else begin
                cur_box_row <= cur_box_row + 1;
            end
        end
    end

    assign box_row = cur_box_row;
    assign box_col = cur_box_col;

endmodule