Gain g1 => dac.left;
Gain g2 => dac.right;


fun void fly(float minf, float maxf, float ibal, float ebal) {
    VoicForm voc;
    Gain left;
    Gain right;
    5 => int n;
    float waits[n];
    0 => float total;
    for ( 0 => int i; i < n; i+1=>i) {
        Math.random2f(20,300) => waits[i];
        total + waits[i] => total;
    }
    ibal=> float start ;
    ebal=> float end;
    //Math.random2f(0.0,1.0) => float start;
    //Math.random2f(0.0,1.0) => float end;
    voc => left;
    voc => right;
    left => g1;
    right => g2;
    0.5 => voc.gain;
    80.0 => voc.freq;
    2 * Math.random2( 0,2 ) => int bphon;
    bphon => voc.phonemeNum;
    Math.random2f(minf,maxf) => float minfreq;
    [    "eee" , "ihh" , "ehh",  "aaa", 
    "ahh" , "aww" , "ohh",  "uhh", 
    "uuu" , "ooo" , "rrr",  "lll", 
    "mmm" , "nnn" , "nng",  "ngg", 
    "fff" , "sss" , "thh",  "shh", 
    "xxx" , "hee" , "hoo",  "hah", 
    "bbb" , "ddd" , "jjj",  "ggg", 
    "vvv" , "zzz" , "thz",  "zhh" ] @=> string allphones[];
    //Math.random2(1,7) => int n;
    string phones[n];
    for ( 0=>int i; i < n ; i+1 => i) {
        allphones[Math.random2(0,allphones.cap()-1)] => phones[i];
        <<< phones[i] >>>;
    }

    for ( 0 => int i; i < n; i+1=>i) {
        phones[i % phones.cap()] => voc.phoneme;
        (i * 1.0) / (n-1) => float far;
        ( far * end + (1-far) * start ) => float balance;
        1.0 - balance => left.gain;
        balance => right.gain;
        waits[i]::ms => now;
    }
}
20 => float minf;
10000 => float maxf;
[40.0,40.0,80.0,120.0,160.0,120.0,120.0,1000] @=> float mins[];
[60.0,80.0,120.0,160.0,200.0,240.0,480.0,1000,2000,3000] @=> float maxes[];
0 => int i;
while(true) {
    mins[i % mins.cap()] => minf;
    maxes[i % maxes.cap()] => maxf;
    //Math.random2f(0.99,1.01) * minf => minf;
    //Math.random2f(0.99,1.01) * maxf => maxf;
    Math.random2f(0,1.0) => float start;
    Math.random2f(0,1.0) => float end;
    Math.random2f(20,180)::ms => now;
    spork ~ fly(minf,maxf, start, end);
    i + 1 => i;
}
