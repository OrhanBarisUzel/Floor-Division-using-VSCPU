`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:48:13 05/31/2023
// Design Name:   VerySimpleCPU
// Module Name:   C:/224Projects/VSCPU_FloorDivision/VSCPU_FloorDivision_tb.v
// Project Name:  VSCPU_FloorDivision
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: VerySimpleCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;
parameter SIZE = 14, DEPTH = 2**14;

reg clk;
initial begin
  clk = 1;
  forever
	  #5 clk = ~clk;
end

reg rst;
initial begin
  rst = 1;
  repeat (10) @(posedge clk);
  rst <= #1 0;
  repeat (300) @(posedge clk);
  $finish;
end
  
reg interrupt;
initial begin
  interrupt = 1'b0;
  repeat (56) @(negedge clk);
  interrupt <=#1 1;
  @ (posedge clk);
   interrupt <=#1 0;
end
  
wire wrEn;
wire [SIZE-1:0] addr_toRAM;
wire [31:0] data_toRAM, data_fromRAM;

VerySimpleCPU inst_VerySimpleCPU(
  .clk(clk),
  .rst(rst),
  .wrEn(wrEn),
 .data_fromRAM(data_fromRAM),
  .addr_toRAM(addr_toRAM),
  .data_toRAM(data_toRAM),
  .interrupt (interrupt)
  
);

  blram #(SIZE, DEPTH) inst_blram(
  .clk(clk),
  .i_we(wrEn),
  .i_addr(addr_toRAM),
  .i_ram_data_in(data_toRAM),
  .o_ram_data_out(data_fromRAM)
);
	initial begin
		blram.memory[0] = 32'h10190065;
		blram.memory[1] = 32'h10194004;
		blram.memory[2] = 32'h80188065;
		blram.memory[3] = 32'h20194065;
		blram.memory[4] = 32'h10194001;
		blram.memory[5] = 32'h8018c064;
		blram.memory[6] = 32'h6018c062;
		blram.memory[7] = 32'hc0258063;
		blram.memory[8] = 32'hd0260000;
		blram.memory[9] = 32'h190065;
		blram.memory[10] = 32'h10198001;
		blram.memory[11] = 32'hd025c000;
		blram.memory[98] = 32'h0;
		blram.memory[99] = 32'h0;
		blram.memory[100] = 32'h0;
		blram.memory[101] = 32'h0;
		blram.memory[102] = 32'h0;
		blram.memory[150] = 32'h9;
		blram.memory[151] = 32'h5;
		blram.memory[152] = 32'hc;
      

    end
  
endmodule

