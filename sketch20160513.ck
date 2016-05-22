
function void drone(int midinote, int t) {
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
    Std.mtof(midinote) => s1.freq;
    2*s1.freq() => s3.freq => s4.freq;
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
}

1.001 => float s1m;
1.003 => float s3m;

fun void lfun(SinOsc s1, SinOsc s2, SinOsc s3, SinOsc s4) {
    while(1::ms => now) {
        s1.freq() * Std.rand2f(2.0 - s1m,s1m) => s1.freq;
        s1.freq() * Std.rand2f(s1m,s3m) => s2.freq;
        s3.freq() * Std.rand2f(2.0 -  s1m,s1m) => s3.freq;
        s3.freq() * Std.rand2f(s1m,s3m) => s4.freq;
    }
}
0 => int count;
function void simpledrone(int midinote, int t) {
    SinOsc s1 => Gain g => ADSR a => dac;
    SinOsc s2 => g;
    SinOsc s3 => g;
    SinOsc s4 => g;
    1.0 => a.target;
    1000::ms => a.attackTime;
    0.5 => a.sustainLevel;
    1000::ms => a.decayTime;
    1000::ms => a.releaseTime;
    count + 1 => count;
    //0.25 => g.gain;
    0.25 * 1.0/count => g.gain;
    Std.mtof(midinote) => s1.freq;
    2*s1.freq() => s3.freq => s4.freq;
    <<< ("Starting", me.id(), "For", t/1000, "at", s1.freq()) >>>;
    1 => a.keyOn;
    spork ~ lfun(s1,s2,s3,s4);
    t :: ms => now;
    1 => a.keyOff;
    1000 :: ms => now;
    count - 1 => count;
}



Std.rand2(30,65) => int midi;
Std.rand2(1000,10000) => int t;
spork ~ simpledrone(midi, t);
//10::second => now;

//for ( 0 => i; i < 64;
//Create an OscRecv object:
OscRecv orec;
//Tell the OscRecv object the port:
10000 => orec.port;
//Tell the OscRecv object to start listening for OSC messages on that port:
orec.listen();


function void fourch(OscEvent fourchEvent) {
    while ( true ) {
        <<< "waiting" >>>;
        fourchEvent => now; //wait for events to arrive.
        while( fourchEvent.nextMsg() != 0 ) {
            fourchEvent.getFloat() => float f1;
            fourchEvent.getFloat() => float f2;
            fourchEvent.getFloat() => float f3;
            fourchEvent.getFloat() => float f4;
            <<< (f1,f2,f3,f4) >>>;
            1.0 + 0.25*(f3-64)/64 => s1m;
            1.0 + 0.25*(f4-64)/64 => s3m;
            spork ~ simpledrone(f1 $ int, (f2*500) $ int);
        }
    }
}


function void multiPitchLength(OscEvent multiEvent) {
    while ( true ) {
        <<< "waiting for multi" >>>;
        multiEvent => now; //wait for events to arrive.
        while( multiEvent.nextMsg() != 0 ) {
            <<< "Got Multi" >>>;
            multiEvent.getFloat() * 127 => float f1;
            multiEvent.getFloat() * 127 => float f2;
            <<< (f1,f2) >>>;
            if (count < 40) {
                spork ~ simpledrone(f1 $ int, (20+f2*500) $ int);
                2::ms => now;
            } else {
                <<< "TOO MUCH!" >>>;
                2::ms => now;
            }
        }
    }
}

function void multiRange(OscEvent multiEvent) {
    while ( true ) {
        <<< "waiting for multi" >>>;
        multiEvent => now; //wait for events to arrive.
        while( multiEvent.nextMsg() != 0 ) {
            <<< "Got Multi" >>>;
            multiEvent.getFloat() * 127 => float f1;
            multiEvent.getFloat() * 127 => float f2;
            //<<< (f1,f2) >>>;
            1.0 + 0.25*(f1-64)/64 => s1m;
            1.0 + 0.25*(f2-64)/64 => s3m;
            <<< (s1m,s3m) >>>;
            2::ms => now;
        }
    }
}


orec.event("/mixer/fourch, f, f, f, f") @=> OscEvent fourchEvent;
spork ~ fourch(fourchEvent);
orec.event("/multi/1, f, f") @=> OscEvent multiEvent;
spork ~  multiPitchLength(multiEvent);
orec.event("/multi/2, f, f") @=> OscEvent multiEvent2;
spork ~  multiRange(multiEvent2);


while( true ) {
    10000::ms => now;
    <<< "sleeping" >>>;
}

