# ALU_32bits 
This is Arithmetic Logic Units where it contains several  computing units .Those units are adder ,subtarctor ,multiplier, divider ,and,or , xor ,logical shift right ,logical shift left .
Here i implemented carry look ahead adder that done addition wth time complexity o(log(n))  giving performance upto around 62 % as compare of ripple carry adder with time complexity o(n) .
Here , i also used that carry look ahead adder for subtaction by addition 2's complement so that it also gives same performance benifit as adder.
And similarly multiplier and divisors use that cla unis.
Here ,i implemented the mutiplier with booth algorithm with radix 2 that will take max time of o(n) and for muliple values of multiplier value that done multiplication significant fast .
Here ,i done division by restoring divider unit.
And ,for shifting by left and right  range upto 0 to 31 bits ,and for that I used barrel shifter that gives shifting result with time of O(1) , givinng massive performance benefits .
