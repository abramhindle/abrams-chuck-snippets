// karplus + strong plucked string filter
// Ge Wang (gewang@cs.princeton.edu)

// feedforward
SinOsc imp => OneZero lowpass => dac;
// feedback
lowpass => Delay delay => lowpass;

Std.rand2f(0.999,0.99999) => float R;
//.99999 => float R;
// our delay order
Std.rand2f(500,2000) => float L;
<<<R>>>;
<<<L>>>;


while (L > 0) {

    // our radius1
    // set delay
    L::samp => delay.delay;
    // set dissipation factor
    Math.pow( R, L ) => delay.gain;
    // place zero
    -1 => lowpass.zero;

    // fire excitation
    1 => imp.gain;
    // for one delay round trip
    L::samp => now;
    //L::samp => now;
    // cease fire
    0 => imp.gain;
    
    // advance time
    (Math.log(.0001) / Math.log(R))::samp => now;
    L - 1 => L;
}
