`timescale 1ns / 1ps

module usb_seg_top (
		input  clk_sys,
		input  sys_reset_n,
		input  uart_rx,
		output uart_tx,
		output [7:0] smg_data,
		output [2:0] scan_sig
);

wire [7:0] uart_rx_data_o;
wire uart_rx_done;
wire [11:0] number_sig;
wire uart_control_done;

uart_rx_path uart_rx_path_u (
    .clk_i(clk_sys), 
    .uart_rx_i(uart_rx), 
    .uart_rx_data_o(uart_rx_data_o), 
    .uart_rx_done(uart_rx_done)
    );

uart_tx_path uart_tx_path_u (
    .clk_i(clk_sys), 
    .uart_tx_data_i(uart_rx_data_o), 
    .uart_tx_en_i(uart_rx_done), 
    .uart_tx_o(uart_tx)
    );
	 
uart_control uart_control_u (
	.clk(clk_sys),
	.reset_n(sys_reset_n),
	.uart_data(uart_rx_data_o),
	.uart_control_en(uart_rx_done),
	.uart_control_out(number_sig),
	.uart_control_done(uart_control_done)
	);
	 
smg_interface smg_interface_u (
    .CLK(clk_sys),
	 .RSTn(sys_reset_n),
	 .Number_Sig(number_sig),
	 .SMG_Data(smg_data),
	 .Scan_Sig(scan_sig)
	);
 
endmodule
