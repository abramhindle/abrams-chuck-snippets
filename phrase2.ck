VoicForm voc=> JCRev r => dac;
0.5 => voc.gain;
80.0 => voc.freq;
0.8 => r.gain;
Math.random2f(0.1,0.4) => r.mix;

2 * Math.random2( 0,2 ) => int bphon;
bphon => voc.phonemeNum;

Math.random2f(2,40) => float center;
Math.random2f(0.9 * center * 20 , 1.1* center * 20) => float minfreq;


<<<minfreq>>>;
//["eee","ahh","uuu","ooo"] @=> string allphones[];
//["sss","xxx","zhh","ooo","eee","aaa","ddd"] @=> string phones[];
[    "eee" , "ihh" , "ehh",  "aaa", 
     "ahh" , "aww" , "ohh",  "uhh", 
     "uuu" , "ooo" , "rrr",  "lll", 
     "mmm" , "nnn" , "nng",  "ngg", 
     "fff" , "sss" , "thh",  "shh", 
     "xxx" , "hee" , "hoo",  "hah", 
     "bbb" , "ddd" , "jjj",  "ggg", 
     "vvv" , "zzz" , "thz",  "zhh" ] @=> string allphones[];

// [ 
//       "thh",
//       "xxx" , "hee" ,
//       "vvv" , "zzz" , "thz",  "zhh" ] @=> string allphones[];
//  

Math.random2(1,20) => int n;
//5 => int n;
string phones[n];
float waits[n];

//["rrr","ooo","aaa","ooo","mmm"] @=>phones;

Math.random2(10,25) => int m;
while( m > 0) {
    //m - 1 => m; //inf loop!
for ( 0=>int i; i < n ; i+1 => i) {
    allphones[Math.random2(0,allphones.cap()-1)] => phones[i];
    Math.random2f(50,1005) => waits[i];
    <<< phones[i] >>>;
}
//["sss","eee","xxx"] @=> string phones[];

0 => int index;
Math.random2(10,20) => int t;
<<<t>>>;
while (t > 0) {
    t - 1 => t;
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
    //Math.random2f(50,400)::ms => now;
    waits[index % waits.cap()]::ms => now;
    
}
}
<<<" phrsae done">>>;
