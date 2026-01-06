pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/bitify.circom";

// Create a circuit which takes an input 'a' (array of length 2), 
// implements power modulo (a[0] ^ a[1]), and returns it using output 'c'.

template Pow() {
   signal input a[2]; // a[0] = base, a[1] = exponent
   signal output c;

   // Using square and multiply algorithm
   component n2b = Num2Bits(254);
   n2b.in <== a[1];

   signal base_powers[255]; // base^(2^i) (The "Square" part)
   signal result[255];  // Tracks the accumulated result
   signal mult[254]; // Intermediate signal to avoid cubic constraints

   base_powers[0] <== a[0];
   result[0] <== 1;

   // Square and Multiply Loop
   for (var i = 0; i < 254; i++) {      
      // If bit is 0, multiplier is 1. If bit is 1, multiplier is base_powers[i].
      // Formula: multiplier = (base_powers[i] - 1) * bit + 1
      mult[i] <== (base_powers[i] - 1) * n2b.out[i] + 1;

      // multiply
      result[i+1] <== result[i] * mult[i];

      // next input is the square of the previous
      base_powers[i+1] <== base_powers[i] * base_powers[i];
   }

   c <== result[254];
}

component main = Pow();