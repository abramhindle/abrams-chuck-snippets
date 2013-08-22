
fun float logit( float z ) {
    return Math.exp(z)/(1+Math.exp(z));
}

Gain g => dac;

fun void buzz(dur length, float x, float y, float z) {
    SinOsc b => PRCRev p => ADSR e => g;
    0.1 => e.gain;
    e.set( length * 1/10, 1/10 * length, 0.5, length/10 );
    0.5 => b.gain ;
    length / 10 => dur attack;
    40 + 440 * logit(x + y + z) => float freq;
    b.freq( freq );
    0.3 + 5*logit(x + y) => float vibrato;
    0.5 + 0.5 * logit(z - x - y) => float mix;
    p.mix( mix );
    e.keyOn();
    (length * 9 / 10) => now;
    e.keyOff();
    (length * 5 / 10) => now;
}

10 => int n;
float z[n];
float x[n];
float y[n];
float dz[n];
float dx[n];
float dy[n];

for (0 => int i; i < n ; 1 + i => i) {
    0 => z[i] => x[i] => y[i];
    0 => dz[i] => dx[i] => dy[i];
}

while(true) {
    for (0 => int i; i < n ; 1 + i => i) {
        0.999 * (dy[i] + Std.rand2f(-0.1,0.1)) => dy[i];
        0.999 * (dx[i] + Std.rand2f(-0.1,0.1)) => dx[i];
        0.999 * (dz[i] + Std.rand2f(-0.1,0.1)) => dz[i];
        dy[i] + y[i] => y[i];
        dx[i] + x[i] => x[i];
        dz[i] + z[i] => z[i];
        //<<< x[i], y[i], z[i] >>>;
        //<<< i, dx[i], dy[i], dz[i] >>>;
        spork ~ buzz(Std.rand2f(60,300)::ms, x[i], y[i], z[i]);        
        Std.rand2f(0,3)::ms => now;
    }
    Std.rand2f(10,100)::ms => now;
}
