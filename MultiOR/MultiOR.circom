pragma circom 2.1.8;

// Write a circuit that returns true when at least one
// element is 1. It should return false if all elements
// are 0. It should be unsatisfiable if any of the inputs
// are not 0 or not 1.

template MultiOR(n) {
    signal input in[n];
    signal output out;

    signal acc[n];

    // Binary constraint on the first bit.
    in[0] * (in[0] - 1) === 0;
    // Feed first bit into acc.
    acc[0] <== in[0];

    for (var i = 1; i < n; i++) {
        // Binary constraint on the ith bit.
        in[i] * (in[i] - 1) === 0;
        // Perform OR operation on the acc's previous bit and the current input bit.
        acc[i] <== acc[i - 1] + in[i] - acc[i - 1] * in[i];
    }

    out <== acc[n - 1];
}

component main = MultiOR(4);
