module p_and (a,b,c) ;
input a,b;
output c ;
assign c = a&b ;
endmodule
module And32(a,b,c);
input [31:0] a,b;
output wire [31:0]c;
genvar i;
generate for (i=0;i<32;i=i+1)
    begin 
        p_and aNd (.a(a[i]),.b(b[i]),.c(c[i])) ;
end 
endgenerate 
endmodule