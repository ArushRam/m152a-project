`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2024 12:56:07 PM
// Design Name: 
// Module Name: debounce_metastabilize
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debounce_metastabilize(
    btn, clk,
    debounced_signal
    );
    
    input clk;
    input btn;
    output debounced_signal;
    
    reg [15:0] dbc_cnt = 0;
    reg debounced_signal_temp = 0;
    reg sync_1 = 0;
    reg sync_2 = 0;
    
    // flip flop for metastabilization
    always @ (posedge clk) begin
        sync_1 <= btn;
        sync_2 <= sync_1;
    end
    
    // debouncing
    always @ (posedge clk) begin
        if (debounced_signal_temp == sync_2) begin
            dbc_cnt = 0;
        end
        
        else begin
            // change in debounced button
            dbc_cnt = dbc_cnt + 1;
            if (dbc_cnt == 50000) begin
                debounced_signal_temp <= sync_2;
                dbc_cnt = 0;
            end
        end
    end
    
    assign debounced_signal = debounced_signal_temp;
    
endmodule
