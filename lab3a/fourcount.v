module test4count(CLK, Q, CLRN,DNUP, INDATA,LDN,SETN);
//Functional level module
input CLK,CLRN,DNUP,LDN,SETN;
input [3:0]INDATA;
output reg [3:0] Q;
always @(negedge CLRN or
negedge SETN or
posedge CLK)
begin
if (CLRN==0) Q=0; // asyn reset
else if (SETN==0) Q=INDATA; // aysn. load
else if (LDN==0) Q=INDATA; // syn load
else if (DNUP==1) Q=Q-1'b1; // syn. count down
else Q=Q+1; // syn. count up
end
endmodule
module fourcount(Z,clock); // top of hierarchy
//Gate Level module
input clock;
output Z;
wire [3:0]count;
test4count instname(clock,count,1,0,4'b0,1,1); // set some control inputs to default values
and(Z,z,~clock);
and(z,count[0],count[1], count[2],count[3]); // Z goes high if count = 1111
endmodule