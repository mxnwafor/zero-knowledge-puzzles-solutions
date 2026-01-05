pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Use the same constraints from IntDiv, but this
// time assign the quotient in `out`. You still need
// to apply the same constraints as IntDiv

template IntDivOut(n) {
    signal input numerator;
    signal input denominator;
    signal output out;
    
    signal quotient;
    signal remainder;

    component isz = IsZero();
    component lt = LessThan(252);

    // zero check for denominator
    isz.in <== denominator;
    isz.out === 0;

    // calculate quotient
    quotient <-- numerator \ denominator;
    // calculate remainder
    remainder <-- numerator % denominator;

    // check less than
    lt.in[0] <== remainder;
    lt.in[1] <== denominator;
    lt.out === 1;

    numerator === denominator * quotient + remainder;

    // assign quotient in out.
    out <== quotient;
}

component main = IntDivOut(252);
