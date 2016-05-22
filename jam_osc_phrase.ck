VoicForm voc=> JCRev r => dac;
0.5 => voc.gain;
80.0 => voc.freq;
0.5 => r.gain;
Math.random2f(0.1,0.4) => r.mix;
//0 => r.mix;

2 * Math.random2( 0,2 ) => int bphon;
bphon => voc.phonemeNum;

Math.random2f(600,700) => float minfreq;
<<<minfreq>>>;
//["eee","ahh","uuu","ooo"] @=> string phones[];
//["sss","xxx","zhh","ooo","eee","aaa","ddd"] @=> string phones[];
[    "eee" , "ihh" , "ehh",  "aaa", 
     "ahh" , "aww" , "ohh",  "uhh", 
     "uuu" , "ooo" , "rrr",  "lll", 
     "mmm" , "nnn" , "nng",  "ngg", 
     "fff" , "sss" , "thh",  "shh", 
     "xxx" , "hee" , "hoo",  "hah", 
     "bbb" , "ddd" , "jjj",  "ggg", 
     "vvv" , "zzz" , "thz",  "zhh" ] @=> string allphones[];
//["sss","xxx","zhh","ooo","eee","aaa","ddd"] @=> string allphones[];
[    "eee" , "ihh" , "ehh",  "aaa", 
     "ahh" , "aww" , "ohh",  "uhh", 
     "uuu" , "ooo"  ] @=> string vowels[];

[  
     "rrr",  "lll", 
     "mmm" , "nnn" , "nng",  "ngg", 
     "fff" , "sss" , "thh",  "shh", 
     "xxx" , "hee" , "hoo",  "hah", 
     "bbb" , "ddd" , "jjj",  "ggg", 
     "vvv" , "zzz" , "thz",  "zhh" ] @=> string consonants[];

OscRecv orec;
10000 => orec.port;
orec.listen();

fun void randit() {
    Math.random2f( 0.6, 0.8 ) => voc.noteOn;
    Math.random2f( 0.7, 1.0 ) => voc.voiced;
    Math.random2f( 0.0, 1.0 ) => voc.unVoiced;
    Math.random2f(0.1,90) => voc.vibratoFreq;
    Math.random2f(0.3,1) => voc.loudness;
    Math.random2f(0,1) => voc.speak;
    Math.random2f(0.1,0.4) => r.mix;
}


fun void multi1(string path, string phone) {
    orec.event(path + ", i") @=> OscEvent ex;
    float y;
    while ( true ) {
        ex => now;
        while ( ex.nextMsg() != 0 ) {
            ex.getInt() => y;
            if ( y > 0 ) {
                <<< (path,phone) >>>;
                phone => voc.phoneme;
            }
        }
        100::ms => now;
    }
}

fun void setpitch(string path, float pitch) {
    orec.event(path + ", i") @=> OscEvent ex;
    float y;
    while ( true ) {
        ex => now;
        while ( ex.nextMsg() != 0 ) {
            ex.getInt() => y;
            if ( y > 0 ) {
                <<< (path,pitch) >>>;
                pitch => voc.freq;
                randit();
            }
        }
        100::ms => now;
    }
}


// a column of phonemes
for (0 => int i; i < 32; i + 1 => i) {
    i % 4 + 8 * (i / 4) => int j;
    <<<i,j>>>;
    spork ~ multi1("/multi/" + j,allphones[i % allphones.cap()]);    
}
// a column of pitch
for (0 => int i; i < 32; i + 1 => i) {
    4 + i % 4 + 8 * (i / 4) => int j;
    <<<i,j>>>;
    spork ~ setpitch("/multi/"+j,Std.mtof(96-2*i));    
}


while( true ) {
    //Math.random2f(-1.0,1.0) => arr[Math.random2( 0, sr )];
    100::ms => now;
}
