pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/gates.circom";

// Write a circuit that returns true when at least one
// element is 1. It should return false if all elements
// are 0. It should be unsatisfiable if any of the inputs
// are not 0 or not 1.

template MultiOR(n) {
    signal input in[n];
    signal output out;

    component equal[n];
    component or[n - 1];

    signal acc[n];  // stores each equal.out
    signal k;
    k <== 1;

    for (var i = 0; i < n; i++) {
        // Binary constraint
        in[i] * (in[i] - 1) === 0;
        equal[i] = IsEqual();

        equal[i].in[0] <== in[i];
        equal[i].in[1] <== k;

        if (i == 0) {
            acc[i] <== equal[i].out;
        } else {
            // since OR doesn't do any comparison on i = 0, it has to start at i = 1
            or[i - 1] = OR();
            // compare prev output (a[i - 1]) to current one (equal[i].out)
            or[i - 1].a <== acc[i - 1];
            or[i - 1].b <== equal[i].out;
            acc[i] <== or[i - 1].out;
        }
    }

    out <== acc[n - 1];
}

component main = MultiOR(4);
