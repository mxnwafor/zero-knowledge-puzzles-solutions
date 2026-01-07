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

    component equal[n];
    component and[n - 1];

    signal acc[n];
    signal k;
    k <== 1;

    for (var i = 0; i < n; i++) {
        // Binary Constraint
        in[i] * (in[i] - 1) === 0;
        equal[i] = IsEqual();

        equal[i].in[0] <== in[i];
        equal[i].in[1] <== k;

        if (i == 0) {
            acc[i] <== equal[i].out;
        } else {
            and[i - 1] = AND();
            and[i - 1].a <== acc[i - 1];
            and[i - 1].b <== equal[i].out;
            acc[i] <== and[i - 1].out;
        }
    }

    out <== acc[n - 1];
}

component main = MultiANDY(4);
