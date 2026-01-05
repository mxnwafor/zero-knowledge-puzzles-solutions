pragma circom 2.1.8;

template Summation(n) {
    signal input in[n];
    signal input sum;

    // constrain sum === in[0] + in[1] + in[2] + ... + in[n-1]
    // this should work for any n

    var acc;
    for (var i = 0; i < n; i++) {
        acc += in[i];
    }

    sum === acc;
}

component main = Summation(8);