pragma circom 2.1.8;

include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/gates.circom";

// Create a circuit that takes an array of signals `in[n]` and
// a signal k. The circuit should return 1 if `k` is in the list
// and 0 otherwise. This circuit should work for an arbitrary
// length of `in`.

template HasAtLeastOne(n) {
    signal input in[n];
    signal input k;
    signal output out;

    // since signals are immutable, we need a way to store the outcomes of searching for k.
    signal acc[n];

    component equal[n];      // compare k with i n times
    component or[n - 1];     // compare each equal.out n - 1 times

    for (var i = 0; i < n; i++) {
        equal[i] = IsEqual();

        // the output of this computation is stored in acc[n]
        equal[i].in[0] <== in[i];
        equal[i].in[1] <== k;

        if (i == 0) {
            acc[i] <== equal[i].out;
        } else {
            // since OR doesn't do any comparison on i = 0, it has to start at i = 1
            or[i - 1] = OR();
            or[i - 1].a <== acc[i - 1];    // either prev was 1,
            or[i - 1].b <== equal[i].out;  // or current is 1
            acc[i] <== or[i - 1].out;
        }
    }

    // assign & constrain out to the last element of acc
    out <== acc[n - 1];

}

component main = HasAtLeastOne(4);
