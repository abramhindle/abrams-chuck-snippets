


fun float logit( float z ) {
    return Math.exp(z)/(1+Math.exp(z));
}

Gain g => dac;

fun void buzz(dur length, float x, float y, float z) {
    //SinOsc b => Modulate m => PRCRev p => ADSR e => dac;
    //BeeThree b => Modulate m => PRCRev p => ADSR e => dac;
    //PulseOsc b => Module m => ADSR e => PRCRev p => g;
    SawOsc b => PRCRev p => ADSR e => g;    
    e.set( length * 10/100, 8/100 * length, .5, length/10 );
    0.5 => b.gain ;
    //SqrOsc b => PRCRev p => ADSR e => dac;
    length / 10 => dur attack;
    40 + 440 * logit(x + y + z) => float freq;
    <<< freq >>>;
    b.freq( freq );
    0.3 + 5*logit(x + y) => float vibrato;
    //<<< vibrato >>>;
    //m.vibratoRate( vibrato );
    //m.vibratoGain( 0.8 );
    //m.randomGain( 0.8 );
    0.5 + 0.5 * logit(z - x - y) => float mix;
    <<< mix >>>;
    p.mix( mix );
    //attack => e.attackTime ;
    //attack => e.decayTime ;
    //attack => e.releaseTime ;
    //0.5 => e.sustainLevel;
    e.keyOn();
    (9 * length / 10) => now;
    e.keyOff();
    5 * length / 10 => now;
}

for( 0 => float z; z < 100; z+Std.rand2f(0.1,2) => z) {
    0 => float y;
    0 => float x;
    for ( 0 => int i ; i < 30; i + 1 => i) {
        y + Std.rand2f(-2,2) => y;
        x + Std.rand2f(-2,2) => x;
        spork ~ buzz(Std.rand2f(10,1000)::ms, x, y, z);
        Std.rand2f(10,30)::ms => now;
    }
}
