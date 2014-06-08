//-------------------------------------------------------------------
//FIFO
//ECE 474 Hw #3 / FIFO Project

//Cary 'Rosie' Guske
//-------------------------------------------------------------------

module fifo ( 
       input            wr_clk,   //write clock
       input            rd_clk,   //read clock
       input            reset_n,  //reset async active low
       input            wr,       //write enable 
       input            rd,       //read enable    
       input      [7:0] data_in,  //data in
       output reg [7:0] data_out, //data out
       output reg         empty,    //empty flag
       output reg         full      //full flag
);

reg [7:0] byte_0;
reg [7:0] byte_1;
reg [7:0] byte_2;
reg [7:0] byte_3;
reg [7:0] byte_4;
reg [7:0] byte_5;
reg [7:0] byte_6;
reg [7:0] byte_7;

reg empty_ps, empty_ns, full_ps, full_ns;//states for both mealys

reg [2:0] rd_address; //count time for read
reg [2:0] wr_address; //count time for write
reg  msb_rd_addr = 0; //rd_address msb init as 0
reg  msb_wr_addr = 0; //wr_address msb init as 0


parameter byte0 	= 3'b000;
parameter byte1 	= 3'b001;
parameter byte2 	= 3'b010;
parameter byte3 	= 3'b011;
parameter byte4 	= 3'b100;
parameter byte5 	= 3'b101;
parameter byte6 	= 3'b110;
parameter byte7 	= 3'b111;




//-------------------------------------------------------------------------------
// read code 
//-------------------------------------------------------------------------------
  always_comb begin
	case (rd_address)
		byte0: data_out <= byte_0; 
		byte1: data_out <= byte_1;
		byte2: data_out <= byte_2;
		byte3: data_out <= byte_3;
		byte4: data_out <= byte_4;
		byte5: data_out <= byte_5;
		byte6: data_out <= byte_6;
		byte7: data_out <= byte_7;
	endcase
  end


//-------------------------------------------------------------------------------
// write code 
//-------------------------------------------------------------------------------
  always_ff @(posedge wr_clk, negedge reset_n)
    	if (!reset_n) begin //start reset code
		byte_0     	<= 8'b00;
		byte_1      	<= 8'b00;
		byte_2      	<= 8'b00;
		byte_3      	<= 8'b00;
		byte_4      	<= 8'b00;
		byte_5      	<= 8'b00;
		byte_6      	<= 8'b00;
		byte_7      	<= 8'b00;
	end //end reset code
	else  if (wr) begin //start writing values code     
		unique case (wr_address)
			3'b000: byte_0 <= data_in; 
			3'b001: byte_1 <= data_in;
			3'b010: byte_2 <= data_in;
			3'b011: byte_3 <= data_in;
			3'b100: byte_4 <= data_in;
			3'b101: byte_5 <= data_in;
			3'b110: byte_6 <= data_in;
			3'b111: byte_7 <= data_in;
		endcase
	end //end writing values code

//-------------------------------------------------------------------------------
//empty and full flag mealys
//-------------------------------------------------------------------------------
 always_ff @(posedge rd_clk, negedge reset_n)
    if (!reset_n) empty_ps <= 1;     //after reset, go to state a
    else          empty_ps <= empty_ns;        //else, go to next state 

 always_ff @(posedge wr_clk, negedge reset_n)
    if (!reset_n) full_ps <= 0;        //after reset, go to state a
    else          full_ps <= full_ns;        //else, go to next state  

  always_comb begin  //start of comb
         
  if (rd_address == wr_address) begin
	if (msb_wr_addr != msb_rd_addr) full_ns = 1;
	else empty_ns = 1;
	end	
	else  begin
		full_ns = 0;
		empty_ns = 0;
	      end
 end//end of comb block

  always_comb begin 
     empty <= empty_ps | empty_ns;
     full <= full_ps | full_ns;
 end//end of comb block




//-------------------------------------------------------------------------------
//adder for rd_address
//-------------------------------------------------------------------------------
  always_ff @(negedge reset_n, posedge rd_clk)
    if (!reset_n) {msb_rd_addr, rd_address}  = 8'h00; //at reset, go to state a
    else if (rd) {msb_rd_addr, rd_address}   = {msb_rd_addr, rd_address} + 1;  //else increment



//-------------------------------------------------------------------------------
//adder for wr_address
//-------------------------------------------------------------------------------
  always_ff @(negedge reset_n, posedge wr_clk)
    if (!reset_n) {msb_wr_addr, wr_address}  = 8'h00; //at reset, go to state a
    else if (wr) {msb_wr_addr, wr_address}   = {msb_wr_addr, wr_address} + 1;  //else increment


endmodule

