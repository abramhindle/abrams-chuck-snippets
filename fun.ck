fun void pulse( float ifreq ) {
    0 => int i;
    50 :: ms => dur len;
    SinOsc s => Envelope e => dac;
    s.gain( 0.1 );
    s.freq( ifreq );
    e.duration( len  );
    e.keyOn();
    len  => now;

    while (Std.rand2f(0,1) > 0.8) {
        spork ~ pulse( ifreq * i );
        i + 1 => i;
    }

    
    e.duration( len  );
    e.keyOff();
    len  => now;
}

for ( 220 => float i ; i < 1000 ; i+1=>i) {
    pulse(i);
}

//while(true) {
//    spork ~ pulse( Std.rand2f(60,440) );
//    Std.rand2f(1,9)::ms => now;
//}
