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
0 => int x;
0 => int t;
// infinite time-loop
while( true )
{
    // set the current sample/impulse
    //Std.rand2f(-1.99,1.99) => i.next;
    //Std.rand2f(0.90,0.9999) => f.prad;
    //brown motion
    Std.rand2f(-1.99,1.99) => step => s.next;
    //Std.rand2f(-1.99,1.99) => step ;//=> s.next;
    //t * (t*3*(t%666)>>3) ^ ((t-300)>>4) ^ (t*t>>6)  => x;
    //(63|t>>3)*((t-10)>>3)  + (254 & t*13 ^ t*16 | t*256)>>3 => x;

    //x % 256 / 256.0 - 0.5 + 0.1 * step => s.next;
    //step + s.next => s.next;
    
    // Std.rand2f(0.1,1.99) => f.prad;   

    // sweep the filter resonant frequency
    Std.fabs(Math.sin(v)) * 400.0 => f.pfreq;
    // increment v
    v + .1 => v;
    t + 1 => t;
    // advance time
    100::samp => now;
}
