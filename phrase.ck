VoicForm voc=> JCRev r => dac;
0.5 => voc.gain;
220.0 => voc.freq;
0.8 => r.gain;
Math.random2f(0.1,0.4) => r.mix;

2 * Math.random2( 0,2 ) => int bphon;
bphon => voc.phonemeNum;

Math.random2f(40,220) => float minfreq;
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
Math.random2(1,7) => int n;
string phones[n];

for ( 0=>int i; i < n ; i+1 => i) {
    allphones[Math.random2(0,allphones.cap()-1)] => phones[i];
    <<< phones[i] >>>;
}
//["sss","eee","xxx"] @=> string phones[];

0 => int index;

while (true) {
    phones[index % phones.cap()] => voc.phoneme;
    index + 1 => index;
    Math.random2f( 0.6, 0.8 ) => voc.noteOn;
    //Math.random2( 20, 40 ) => voc.phonemeNum;
    Math.random2f( 0.9, 1.0 ) => voc.voiced;
    Math.random2f( 0.0, 1.0 ) => voc.unVoiced;
    Math.random2f( minfreq, minfreq*1.05  ) => voc.freq;
    Math.random2f(0.1,90) => voc.vibratoFreq;
    Math.random2f(0.3,1) => voc.loudness;
    Math.random2f(0,1) => voc.speak;
    //Math.random2f(0,1) => voc.quiet;
    //3 => voc.phonemeNum;
    //Math.random2f(1.0/minfreq,100/minfreq)::ms => now;
    //voc.controlChange(4,0);
    Math.random2f(100,1500)::ms => now;
    
}
