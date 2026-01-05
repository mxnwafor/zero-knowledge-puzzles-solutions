pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that is satisfied if `numerator`,
// `denominator`, `quotient`, and `remainder` represent
// a valid integer division. You will need a comparison check, so
// we've already imported the library and set n to be 252 bits.
//
// Hint: integer division in Circom is `\`.
// `/` is modular division
// `%` is integer modulus

template IntDiv(n) {
    signal input numerator;
    signal input denominator;
    signal input quotient;
    signal input remainder;    

    component isz = IsZero();
    component lessThan = LessThan(252);

    // handle division by zero
    // numerator = denominator * quotient + remainder

    isz.in <== denominator;
    isz.out === 0;

    lessThan.in[0] <== remainder;
    lessThan.in[1] <== denominator;
    lessThan.out === 1;

    numerator === denominator * quotient + remainder;

}

component main = IntDiv(252);
