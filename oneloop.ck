Step s => dac;
441 => int sr;
sr => float fsr;
OscRecv orec;
57120 => orec.port;
orec.listen();

-0.1 => float amp; // square wave using Step
0 => int i;
float arr[sr];
//for ( 0 => i ; i < sr ; i + 1 => i ) {
//    Math.sin(440*3.14*2*i/fsr) => arr[i];
//}
fun void play() {
    0 => int i;
    while( true ) {
        arr[i % sr] => s.next;
        i + 1 => i;
        2::samp => now;
    }
}
spork ~ play();
0.0 => float x;
0.0 => float y;
fun void yosc() {
    orec.event("/1/y, f") @=> OscEvent ex;
    0 => int i;
    while ( true ) {
        ex => now;
        while ( ex.nextMsg() != 0 ) {
            ex.getFloat() => y;
            (x * fsr)$ int  => i;
            <<< (y,x,i) >>>;
            y => arr[ (x * fsr) $ int ];
        }
    }
}
fun void xosc() {
    orec.event("/1/x, f") @=> OscEvent ex;
    while ( true ) {
        ex => now;
        while ( ex.nextMsg() != 0 ) {
            ex.getFloat() => x;
        }
    }
}

spork ~ yosc();
spork ~ xosc();

fun void decay() {
    0 => int i;
    while( true ) {
        arr[i % sr] * 0.992 => arr[i % sr];
        i + 1 => i;
        1::samp => now;
    }
}
spork ~ decay();

while( true ) {
    //Math.random2f(-1.0,1.0) => arr[Math.random2( 0, sr )];
    100::ms => now;
}
