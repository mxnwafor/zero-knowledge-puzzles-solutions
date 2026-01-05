pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Write a circuit that constrains the 4 input signals to be
// sorted. Sorted means the values are non decreasing starting
// at index 0. The circuit should not have an output.

template IsSorted(n) {
    signal input in[4];

    component lt[n - 1];    // an array of comparator components.

    for (var i = 0; i < n - 1; i++) {
        lt[i] = LessEqThan(252);
        lt[i].in[0] <== in[i];    // the components contain the input.
        lt[i].in[1] <== in[i + 1];
        lt[i].out === 1;
    }

}

component main = IsSorted(4);
