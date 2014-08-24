PulseOsc l => NRev rl => dac.left;
PulseOsc r => NRev rr => dac.right;
0.0 => rl.mix;
0.0 => rr.mix;
0.1 => l.gain;
0.1 => r.gain;
[100,100,200,200,100,300] @=> int sleeps[];
sleeps.cap() => int nsleep;
0 => int sleepiter;
Math.random2(1,10) => float diff;
20 + Math.random2(1,20) => float base;
Math.random2f(0.01,9)  => float step;
Math.random2(10,1000) => int t;
<<<t>>>;
<<<base>>>;
while (t > 0) {
    t - 1 => t;
    base + step - diff => l.freq;
    base + step + diff => r.freq;
    if (Std.rand2f(0,1) > 0.1) {
        step + Std.rand2f(-1,1) => step;
    }
    Std.rand2f(0,6.0) => float phase;
    phase => r.phase;
    1.01*phase => l.phase;
    sleeps[sleepiter % nsleep]::ms => now;
    //Std.rand2f(100,600)::ms => now;
    sleepiter + 1 => sleepiter;
}
<<<"done">>>;
