Step s => dac;
44100/2 => int sr;
44100 => float fsr;
OscRecv orec;
57120 => orec.port;
orec.listen();

-0.1 => float amp; // square wave using Step
0 => int i;
float arr[sr];
//for ( 0 => i ; i < sr ; i + 1 => i ) {
//    Math.sin(440*3.14*2*i/fsr) => arr[i];
    //}
2 => int multi;
fun void play() {
    0 => int i;
    while( true ) {
        arr[i % sr] => s.next;
        i + 1 => i;
        multi::samp => now;
    }
}

float farr[sr];
float tmp[];

fun void settit(float x, float y) {
    for ( 0 => i ; i < sr ; i + 1 => i ) {
        0.1*x*Math.sin(multi*440*y*3.14*2*i/fsr) + 0.9*arr[i] => farr[i];       
    }
    arr @=> tmp;
    farr @=> arr;
    tmp @=> farr;
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
            (x * sr)$ int  => i;
            <<< (y,x,i) >>>;
            spork ~ settit(0.5,y);
            spork ~ settit(0.5,x);
        }
        100::ms => now;
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

1.0 => float decayv;

fun void sdecay() {
    0 => int i;
    while( true ) {
        arr[i % sr] * decayv => arr[i % sr];
        i + 1 => i;
        10::samp => now;
    }
}
fun void decay() {
    0 => int i;
    while( true ) {
        for ( 0 => i ; i < sr ; i + 1 => i ) {
            arr[i % sr] * decayv => arr[i % sr];
        }
        100::ms => now;
    }
}


// spork ~ decay();

while( true ) {
    //Math.random2f(-1.0,1.0) => arr[Math.random2( 0, sr )];
    100::ms => now;
}
