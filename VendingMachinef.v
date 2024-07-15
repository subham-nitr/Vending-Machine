module VendingMachinef(
 input clk,
 input rst,
 input [1:0]in, // 01 = 5 rs, 10 = 10 rs, 11 = invalid
 output reg[1:0] out,
 output reg[1:0] change,
 output reg [2:0] state_led // 3 LEDs for state indication
 );
 parameter s0 = 2'b00;
 parameter s1 = 2'b01;
 parameter s2 = 2'b10;

 reg[1:0] c_state;

 always@ (posedge clk)
 begin
 if(rst == 1)
 begin
 c_state <= 0;
 out[1:0] <=2'b00;
 change <= 2'b00;
 state_led <= 001; //idle
 end
 else
 c_state <= c_state;

 case(c_state)

 s0: //state 0 : 0 rs
     if(in == 0 && ~rst)
     begin
     c_state <= s0;
     out <= 2'b00;
     change <= 2'b00;
     state_led <= 001; //idle
     end
     else if(in == 2'b01 && ~rst)
     begin
     c_state <= s1;
     out <= 2'b00;
     change <= 2'b00;
     state_led <= 010; //processing
     end
     else if(in == 2'b10 && ~rst)
     begin
     c_state <= s2;
     out <= 2'b00;
     change <= 2'b00;
     state_led <= 010; //processing
      end
     else if(in == 2'b11 && ~rst)
     begin
     c_state <= s0;
     out <= 2'b00;
     change <= 2'b11; //returns invalid coin
     state_led <= 100; //error
     end

 s1: //state 1 : 5 rs
     if(in == 0 && ~rst)
     begin
     c_state <= s0;
     out <= 2'b00;
     change <= 2'b01; //change returned 5 rs
     state_led <= 001; //idle
     end
     else if(in == 2'b01 && ~rst)
     begin
     c_state <= s2;
     out <= 2'b00;
     change <= 2'b00;
     state_led <= 100; //processing
     end
     else if(in == 2'b10 && ~rst)
     begin
     c_state <= s0;
     out <= 2'b10;   //Dispense special item
     change <= 2'b00;
     state_led <= 001; //idle
     end
     else if(in == 2'b11 && ~rst)
     begin
     c_state <= s1;
     out <= 2'b00;
     change <= 2'b11; //returns invalid coin
     state_led <= 100; //error
     end

 s2: //state 2 : 10 rs
     if(in == 0 && ~rst)
     begin
     c_state <= s0;
     out <= 2'b00;
     change <= 2'b10;
     state_led <= 001; //idle
     end
     else if(in == 2'b01 && ~rst)
     begin
     c_state <= s0;
     out <= 2'b01;
     change <= 2'b00;
     state_led <= 001; //idle
     end
     else if(in == 2'b10 && ~rst)
     begin
     c_state <= s0;
     out <= 2'b01;
     change <= 2'b01; //change returned 5 rs and 1 bottle
     state_led <= 001; //idle
     end
     else if(in == 2'b11 && ~rst)
     begin
     c_state <= s2;
     out <= 2'b00;
     change <= 2'b11; //returns invalid coin
     state_led <= 100; //error
     end

     endcase
     end
endmodule