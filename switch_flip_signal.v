`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:56 03/19/2013 
// Design Name: 
// Module Name:    switch_flip_signal
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

module switch_flip_signal(
    input wire switchValue,
    input wire clk,
    output wire changeSignal
);
    reg changeSignal_tmp;
    reg previousValue;

    initial begin
        changeSignal_tmp <= 0;
        previousValue <= switchValue;
    end

    // we need to separate updating
    always @(posedge clk) begin
        previousValue <= switchValue;
    end

    always @(*) begin
        if (switchValue != previousValue) begin
            changeSignal_tmp = 1;
        end
        else begin
            changeSignal_tmp = 0;
        end
    end

    assign changeSignal = changeSignal_tmp;
endmodule