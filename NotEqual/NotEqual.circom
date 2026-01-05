pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/gates.circom";

// Input : a , length of 2 .
// Output : c .
// In this exercise , you have to check that a[0] is NOT equal to a[1], if not equal, output 1, else output 0.
// You are free to use any operator you may like . 

// HINT:NEGATION

template NotEqual() {

    // Your code here.
    signal input a[2];
    signal output c;

    component equal = IsEqual();
    component negation = NOT();

    equal.in[0] <== a[0];
    equal.in[1] <== a[1];

    // assign and constrain value of equal.out to negation.in
    negation.in <== equal.out;

    // assign and constrain value of negation.out to c
    c <== negation.out;
   
}

component main = NotEqual();