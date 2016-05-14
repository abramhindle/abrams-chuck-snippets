SinOsc s1 => Gain g => ADSR a => dac;
SinOsc s2 => g;
SinOsc s3 => g;
SinOsc s4 => g;
1.0 => a.target;
1000::ms => a.attackTime;
0.5 => a.sustainLevel;
1000::ms => a.decayTime;
1000::ms => a.releaseTime;
0.25 => g.gain;
Std.mtof(Std.rand2(4,55)) => s1.freq => s2.freq;
2*s1.freq() => s3.freq => s4.freq;
Std.rand2(10000,100000) => int t;
Std.rand2(100000,900000) => int id;
<<< ("Starting", me.id(), "For", t/1000, "at", s1.freq()) >>>;
1 => a.keyOn;
for (0 => int i; i < t; i + 1 => i) {
    s1.freq() * Std.rand2f(0.999,1.001) => s1.freq;
    s1.freq() * Std.rand2f(1.001,1.003) => s2.freq;
    s3.freq() * Std.rand2f(0.999,1.001) => s3.freq;
    s3.freq() * Std.rand2f(1.001,1.003) => s4.freq;
    if (t - 1000 == i) {
        1 => a.keyOff;
        <<< ("Ending", me.id()) >>>;
    }
    1::ms => now;
}
