pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that is satisfied if
// in[0] is the floor of the integer
// sqrt of in[1]. For example:
// 
// int[2, 5] accept
// int[2, 5] accept
// int[2, 9] reject
// int[3, 9] accept
//
// If b is the integer square root of a, then
// the following must be true:
//
// (b - 1)(b - 1) < a
// (b + 1)(b + 1) > a
// 
// be careful when verifying that you 
// handle the corner case of overflowing the 
// finite field. You should validate integer
// square roots, not modular square roots

template IntSqrt(n) {
    signal input in[2];

    component lt = LessThan(252);
    component gt = GreaterThan(252);

    lt.in[0] <== (in[0] - 1) * (in[0] - 1);
    lt.in[1] <== in[1];

    gt.in[0] <== (in[0] + 1) * (in[0] + 1);
    gt.in[1] <== in[1];

    // assert both outputs
    lt.out === gt.out;
}

component main = IntSqrt(252);
