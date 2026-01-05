pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/gates.circom";


// Input 3 values using 'a'(array of length 3) and check if they all are equal.
// Return using signal 'c'.

template Equality() {
   // Your Code Here..
   signal input a[3];
   signal output c;

   component equal1 = IsEqual();
   component equal2 = IsEqual();

   component and = AND();
   
   equal1.in[0] <== a[0];
   equal1.in[1] <== a[1];
   and.a <== equal1.out;

   equal2.in[0] <== a[1];
   equal2.in[1] <== a[2];
   and.b <== equal2.out;

   c <== and.out;
   
}

component main = Equality();