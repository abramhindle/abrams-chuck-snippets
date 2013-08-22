// impulse to filter to dac
Step s => BiQuad f => dac;
// set the filter's pole radius
.99 => f.prad;
// set equal gain zero's
1 => f.eqzs;
// initialize float variable
0.0 => float v;
0.0 => float step;
0.1 => s.gain ;
0.1 => f.gain ;


// infinite time-loop
while( true )
{
    // set the current sample/impulse
    //Std.rand2f(-1.99,1.99) => i.next;
    Std.rand2f(0.90,0.99) => f.prad;
    Std.rand2f(-1.99,1.99) => step => s.next;
    // Std.rand2f(0.1,1.99) => f.prad;   

    // sweep the filter resonant frequency
    Std.fabs(Math.sin(v)) * 400.0 => f.pfreq;
    // increment v
    v + .1 => v;
    // advance time
    100::samp => now;
}
