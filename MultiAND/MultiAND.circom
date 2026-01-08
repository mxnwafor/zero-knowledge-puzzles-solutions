pragma circom 2.1.8;

// Create a circuit that takes an array of signals `in` and
// returns 1 if all of the signals are 1. If any of the
// signals are 0 return 0. If any of the signals are not
// 0 or 1 the circuit should not be satisfiable.

include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/gates.circom";

template MultiANDY(n) {
    signal input in[n];
    signal output out;

    signal acc[n];

    // Binary constraint.
    in[0] * (in[0] - 1) === 0;
    // Feed first bit into acc.
    acc[0] <== in[0];

    for (var i = 1; i < n; i++) {
        in[i] * (in[i] - 1) === 0;
        // Perform AND operation between previous bit in acc and current input bit.
        acc[i] <== acc[i - 1] * in[i];
    }

    // assign and constrain the last value to out
    out <== acc[n - 1];
}

component main = MultiANDY(4);

