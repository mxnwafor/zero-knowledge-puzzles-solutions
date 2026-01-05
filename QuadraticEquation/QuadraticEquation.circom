pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";

// Create a Quadratic Equation( ax^2 + bx + c ) verifier using the below data.
// Use comparators.circom lib to compare results if equal

template QuadraticEquation() {
    signal input x;     // x value
    signal input a;     // coeffecient of x^2
    signal input b;     // coeffecient of x 
    signal input c;     // constant c in equation
    signal input res;   // Expected result of the equation
    signal output out;  // If res is correct , then return 1 , else 0 . 

    // your code here
    component equal = IsEqual();

    // using intermediate signals
    signal x_sq <== x * x;
    signal term_a <== a * x_sq;
    signal term_b <== b * x;

    equal.in[0] <== term_a + term_b + c;
    equal.in[1] <== res;

    out <== equal.out;
}

component main  = QuadraticEquation();



