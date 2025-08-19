 module booth(m,q,x_out,z_out,b_out,s);
 input signed [3:0]m,q;// input for mulplicand and multiplier
 output reg[7:0]s,d;// output register
 output[6:0]x_out, z_out, b_out;//  output for 7-segment
 reg[3:0] x,y,z,b;
 reg r;// register r for storing LSB of q after every operation
 reg [3:0]t,a;
 reg[7:0]d;
 initial
 begin
 a=4'b0;
 r=1'b0;
 end
 integer i;
 always@(m,q,a)
 begin
 t=-m;// 2's complement of m stored in t
 d={a[3:0],q[3:0]}; // d is initiallized with accumulator and multiplier
 for( i=0;i<4;i=i+1)
 begin
 case ({q[i],r})  // check bits q[i] and r
2'b10 :d[7:4]=d[7:4]+t;
 2'b01 :d[7:4]=d[7:4]+m;
 2'b00 :d[7:4]=d[7:4]+4'b0;
 2'b11 :d[7:4]=d[7:4]+4'b0;
 endcase
 d=d>>1; // for right shifting
 d[7]=d[6];
 r=q[i]; // after every operation LSB of q is stored in to r
 end
 if(m>4'd8 && q>4'd8)
 begin
 s=d;
 end
 else if(m>4'd8)
 begin
 s=-d;
 end
 else if (q>4'd8)
 begin
 s=-d;
 end
 else
 begin
 s=d;
 end
// for BCD conversation
 x=s%4'b1010;
 y=s/4'b1010;
 z=y%4'b1010;
 b=y/4'b1010;
 end
 // for 7 segment
 seven_segment s1(x,x_out);
 seven_segment s2(z,z_out);
 seven_segment s3(b,b_out);
 endmodule
 // module for 7 Segment
 module seven_segment
 (input [3:0]x,
 output reg [6:0]x_out);
 always@(*)
 begin
 case(x)
 4'b0000: x_out=7'b0000001;
 4'b0001: x_out=7'b1001111;
 4'b0010: x_out=7'b0010010;
 4'b0011: x_out=7'b0000110;             
4'b0100: x_out=7'b1001100;            
4'b0101: x_out=7'b0100100;            
4'b0110: x_out=7'b0100000;             
4'b0111: x_out=7'b0001111;             
4'b1000: x_out=7'b0000000;             
4'b1001: x_out=7'b0000100;
 endcase
 end
 endmodule
