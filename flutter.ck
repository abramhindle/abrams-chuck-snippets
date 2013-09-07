PulseOsc l => NRev rl => dac.left;
PulseOsc r => NRev rr => dac.right;
0.0 => rl.mix;
0.0 => rr.mix;
0.1 => l.gain;
0.1 => r.gain;
[10,20,220,100] @=> float [] sleeps;
cap(sleeps) => int sn;
0.1 => float diff;
80 => float base;
0.01  => float step;
while (true) {
    base + step => l.freq;
    base + step + diff => r.freq;
    if (Std.rand2f(0,1) > 0.1) {
        step + Std.rand2f(-1,1) => step;
    }
    Std.rand2f(0,6) => float phase;
    phase => r.phase;
    1.01*phase => l.phase;
    Std.rand2f(220,250)::ms => now;
}
