# FPGA-Based-Design-and-Implementation-of-Booth-Algorithm-Multiplier-in-Verilog
This project implements a Booth Multiplier using Verilog HDL and demonstrates its functionality on an FPGA board. The Booth multiplication algorithm that works for both signed and unsigned binary numbers in two’s complement representation.  Multiplication is a fundamental operation in digital systems and computer architecture.
# Booth Multiplier using Verilog (FPGA Implementation)

## 📌 Project Overview
This project implements a **Booth Multiplier** using **Verilog HDL** and demonstrates its functionality on an **FPGA board**. 
The Booth algorithm, invented by Andrew Donald Booth in 1950, is an efficient multiplication algorithm that works for both 
**signed and unsigned binary numbers** in two’s complement representation.

Multiplication is a fundamental operation in digital systems, and Booth multipliers are widely used in **computer architecture, DSPs, and VLSI design** due to their **speed and power efficiency** compared to traditional array multipliers.

---

## 🔑 Features
- Designed using **Booth’s Algorithm (Radix-2)**.  
- Supports both **positive and negative numbers**.  
- Reduces the number of **partial products**, improving speed.  
- Implemented in **Verilog HDL** and tested on FPGA.  
- Integrated with **7-segment display** for result visualization.  

---

## ⚙️ Methodology
1. Inputs are provided as **Multiplicand (M)** and **Multiplier (Q)**.  
2. Registers `A` and `r` are initialized.  
3. The Booth algorithm checks the last two bits (`q[i]` and `q[i+1]`) and performs one of the following operations:  
   - `00` or `11` → Arithmetic Right Shift  
   - `01` → Add multiplicand to accumulator, then shift  
   - `10` → Subtract multiplicand, then shift  
4. The result is stored in **Accumulator + Multiplier registers**.  
5. Final output is displayed on a **7-segment display**.  

---

## 🖥️ Results
- Verified through **simulation waveforms** and **RTL schematics**.  
- Successfully synthesized and implemented on an **FPGA board**.  
- Output correctly displayed on **7-segment displays**.  

---

## 📚 Learning Outcomes
- Understanding of **Booth’s Algorithm** and its advantages over other multiplication techniques.  
- Hands-on experience with **Verilog coding** and **FPGA implementation**.  
- Exposure to **hardware realization** of arithmetic operations.  

---

## 📖 References
- Ruchi Sharma, *Analysis of Different Multiplier with Digital Filters Using VHDL Language*, IJEAT, 2012.  
- Bhavya Lahari Gundapaneni et al., *Booth Algorithm for the Design of Multiplier*, IJITEE, 2019.  
- [GeeksforGeeks – Booth’s Algorithm](https://www.geeksforgeeks.org/computer-organization-booths-algorithm/)  
- [Javatpoint – Booth’s Algorithm](https://www.javatpoint.com/booths-multiplication-algorithm-in-coa)  

---

## 📂 Code Example

```verilog
module booth(m,q,x_out,z_out,b_out,s);

input signed [3:0]m,q; // input for multiplicand and multiplier
output reg[7:0]s,d;    // output register
output[6:0]x_out, z_out, b_out; // output for 7-segment

reg[3:0] x,y,z,b;
reg r; // register r for storing LSB of q after every operation
reg [3:0]t,a;
reg[7:0]d;

initial begin
  a=4'b0;
  r=1'b0;
end

integer i;
always@(m,q,a) begin
  t=-m; // 2's complement of m stored in t
  d={a[3:0],q[3:0]}; // initialize d with accumulator and multiplier

  for(i=0;i<4;i=i+1) begin
    case({q[i],r})  // check bits q[i] and r
      2'b10 : d[7:4]=d[7:4]+t;
      2'b01 : d[7:4]=d[7:4]+m;
      2'b00 : d[7:4]=d[7:4]+4'b0;
      2'b11 : d[7:4]=d[7:4]+4'b0;
    endcase
    d=d>>1; // right shift
    d[7]=d[6];
    r=q[i]; // update r
  end

  if(m>4'd8 && q>4'd8)
    s=d;
  else if(m>4'd8)
    s=-d;
  else if(q>4'd8)
    s=-d;
  else
    s=d;

  // BCD conversion
  x=s%4'b1010;
  y=s/4'b1010;
  z=y%4'b1010;
  b=y/4'b1010;
end

// 7-segment module
seven_segment s1(x,x_out);
seven_segment s2(z,z_out);
seven_segment s3(b,b_out);
endmodule

module seven_segment(input [3:0]x, output reg [6:0]x_out);
always@(*) begin
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
```

---

## 👤 Author
- **Prince Viradiya**  
  Roll Number: 2BEC144  
  Semester IV, 2EC202 – FPGA-based System Design  
  Institute of Technology, Nirma University  
  Department of Electronics and Communication Engineering  

---
