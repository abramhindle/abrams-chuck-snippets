HevyMetl hm => Envelope e => dac;
//Step s;
//0 => s.next;
hm.noteOn;
0.25 => hm.gain;
666 => hm.freq;
60 => hm.lfoSpeed;
0.5 => hm.lfoDepth;
Std.rand2f(40,80) => float base;
base => float freq;
0.8 => hm.noteOn;
while(true) {
    e.keyOn();
    //Std.rand2f(0.8,1.0) => hm.lfoDepth;
    //Std.rand2f(0.0,1.0) => hm.afterTouch;
    if (Std.rand2f(0,1) > 0.5) {
        Std.rand2f(1,160) => hm.lfoSpeed;
        Std.rand2f(base,base+3) => freq;
    }
    freq => hm.freq;
    //freq => hm.freq;
    //Std.rand2f(1.0,1.1)*freq  => freq;
    //if (freq > base*3) {
    //    base => freq;
    //}
    //Std.rand2f(10,1000)::ms => e.duration;
    //e.duration::ms=>now;
    //e.keyOff();
    Std.rand2f(10,100)::ms=>now;
}

//    .lfoSpeed - ( float , READ/WRITE ) - modulation Speed (Hz)
//    .lfoDepth - ( float , READ/WRITE ) - modulation Depth [0.0 - 1.0]
//    .afterTouch - ( float , READ/WRITE ) - aftertouch [0.0 - 1.0]
//    .controlOne - ( float , READ/WRITE ) - control one [instrument specific]
//    .controlTwo - ( float , READ/WRITE ) - control two [instrument specific]
//
//(inherited from StkInstrument)
//
//    .noteOn - ( float velocity ) - trigger note on
//    .noteOff - ( float velocity ) - trigger note off
//    .freq - ( float frequency ) - set/get frequency (Hz)
//    .controlChange - ( int number, float value ) - assert control change
