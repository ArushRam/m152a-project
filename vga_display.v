`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    vga_display
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
module vga_display(
	input wire clk_display,			            // asynchronous reset
    input wire [2:0] game_state [0:4][0:4],     // game board
    input wire [2:0] cursor_row,                // cursor row position
    input wire [2:0] cursor_col,                // cursor col position
	output wire hsync,		                    // horizontal sync out
	output wire vsync,		                    // vertical sync out
	output reg [2:0] red,	                    // red vga output
	output reg [2:0] green,                     // green vga output
	output reg [2:0] blue	                    // blue vga output
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;

// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge dclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

always @(*) begin
        // Initialize colors to white (blank grid cells)
        red = 3'b111;
        green = 3'b111;
        blue = 3'b111;

        // Define grid cell size and padding
        localparam CELL_WIDTH = 128;
        localparam CELL_HEIGHT = 96;
        localparam LINE_THICKNESS = 3;
        localparam PADDING = 16;
        localparam MARKER_WIDTH = CELL_WIDTH - 2 * PADDING;
        localparam MARKER_HEIGHT = CELL_HEIGHT - 2 * PADDING;

        // Determine the current cell
        integer cell_x = (hc - hbp) / CELL_WIDTH;
        integer cell_y = (vc - vbp) / CELL_HEIGHT;

        // Check if we're within the vertical active video range
        if (vc >= vbp && vc < (vbp + 480)) begin
            // Check if we're within the horizontal active video range
            if (hc >= hbp && hc < (hbp + 640)) begin
                // Draw vertical grid lines with thickness
                if ((hc - hbp) % CELL_WIDTH < LINE_THICKNESS || (hc - hbp) % CELL_WIDTH >= (CELL_WIDTH - LINE_THICKNESS)) begin
                    red = 3'b000;
                    green = 3'b000;
                    blue = 3'b000;
                end
                // Draw horizontal grid lines with thickness
                else if ((vc - vbp) % CELL_HEIGHT < LINE_THICKNESS || (vc - vbp) % CELL_HEIGHT >= (CELL_HEIGHT - LINE_THICKNESS)) begin
                    red = 3'b000;
                    green = 3'b000;
                    blue = 3'b000;
                end
                // Draw player markers based on game state
                else if (cell_x >= 0 && cell_x < 5 && cell_y >= 0 && cell_y < 5) begin
                    if (game_state[cell_y][cell_x] == 1) begin
                        // Draw a filled-in black circle for Player 1
                        integer center_x = hbp + cell_x * CELL_WIDTH + CELL_WIDTH / 2;
                        integer center_y = vbp + cell_y * CELL_HEIGHT + CELL_HEIGHT / 2;
                        integer radius = (MARKER_WIDTH < MARKER_HEIGHT ? MARKER_WIDTH : MARKER_HEIGHT) / 2;
                        if ((hc - center_x)*(hc - center_x) + (vc - center_y)*(vc - center_y) <= radius * radius) begin
                            red = 3'b000;
                            green = 3'b000;
                            blue = 3'b000;
                        end
                    end else if (game_state[cell_y][cell_x] == 2) begin
                        // Draw a filled-in black square for Player 2
                        integer marker_left = hbp + cell_x * CELL_WIDTH + PADDING;
                        integer marker_right = marker_left + MARKER_WIDTH;
                        integer marker_top = vbp + cell_y * CELL_HEIGHT + PADDING;
                        integer marker_bottom = marker_top + MARKER_HEIGHT;
                        if (hc >= marker_left && hc < marker_right && vc >= marker_top && vc < marker_bottom) begin
                            red = 3'b000;
                            green = 3'b000;
                            blue = 3'b000;
                        end
                    end
                end
            end
        end
        // We're outside the active video range, so display black
        else begin
            red = 3'b000;
            green = 3'b000;
            blue = 3'b000;
        end
    end
endmodule
