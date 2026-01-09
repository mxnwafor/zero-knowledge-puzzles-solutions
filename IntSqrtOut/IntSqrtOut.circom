pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Be sure to solve IntSqrt before solving this 
// puzzle. Your goal is to compute the square root
// in the provided function, then constrain the answer
// to be true using your work from the previous puzzle.
// You can use the Bablyonian/Heron's or Newton's
// method to compute the integer square root. Remember,
// this is not the modular square root.


function intSqrtFloor(x) {
    // compute the floor of the
    // integer square root
    
    // Using Heron's method;
    var old_guess = x;
    var new_guess = x;

    if (x != 0) {
        new_guess = (old_guess + x \ old_guess) \ 2;
    }

    while (new_guess < old_guess) {
        old_guess = new_guess;
        new_guess = (old_guess + x \ old_guess) \ 2;
    }

    return old_guess;
}

template IntSqrtOut(n) {
    signal input in;
    signal output out;

    out <-- intSqrtFloor(in);
    // constrain out using your
    // work from IntSqrt
    component lt = LessThan(252);
    component gt = GreaterThan(252);

    // (b - 1)(b - 1) < a
    lt.in[0] <== (out - 1) * (out - 1);
    lt.in[1] <== in;

    // (b + 1)(b + 1) > a
    gt.in[0] <== (out + 1) * (out + 1);
    gt.in[1] <== in; 

}

component main = IntSqrtOut(252);
