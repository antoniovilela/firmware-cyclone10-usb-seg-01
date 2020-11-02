
module uart_control (
	input 			clk,
	input 			reset_n,
	input [7:0] 	uart_data,
	input 			uart_control_en,
	output [11:0] 	uart_control_out,
	output 			uart_control_done
);

wire [11:0] o_BCD;
wire 			o_DV;

Binary_to_BCD #(.INPUT_WIDTH(8), .DECIMAL_DIGITS(3)) (
   .i_Clock(clk),
   .i_Binary(uart_data),
   .i_Start(uart_control_en),
	.reset_n(reset_n),
   //
   .o_BCD(o_BCD),
   .o_DV(o_DV)
   );

assign uart_control_out = o_BCD;
assign uart_control_done = o_DV;

endmodule
