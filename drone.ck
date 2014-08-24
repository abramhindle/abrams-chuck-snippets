//Phasor drive => Gen9 g9 => dac;
Phasor drive => Gen7 g7 => blackhole; // portamento
SinOsc sinO => dac;
sinO.freq(440);
//[1., 1., 0.,   2, 0.5, 90.,   3., 0.2, 180.] => g9.coefs;
//0.1 => g9.gain;
//drive.freq( 440. );
//0 => int i;
[0.0, 1.0, 0.0 ] => g7.coefs;

0 => int i;
while (i < 10)
{
    1000::ms => now;
    i + 1 => i;
    1000 * g7 => sinO.freq;
//    Math.exp(Std.rand2f(0.01,1.0))-1 => float fund;
//    [
//     fund       , Std.rand2f(0.01,1.0), Std.rand2f(0.00,1.0),
//     2.0 * fund , Std.rand2f(0.01,1.0), Std.rand2f(0.00,1.0),
//     3.0 * fund , Std.rand2f(0.01,1.0), Std.rand2f(0.00,1.0),
//     4.0 * fund , Std.rand2f(0.01,1.0), Std.rand2f(0.00,1.0),
//     5.0 * fund , Std.rand2f(0.01,1.0), Std.rand2f(0.00,1.0)
//    ] => g9.coefs;

}
