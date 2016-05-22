VoicForm voc=> JCRev r => dac;
0.5 => voc.gain;
80.0 => voc.freq;
0.5 => r.gain;
Math.random2f(0.1,0.4) => r.mix;

2 * Math.random2( 0,2 ) => int bphon;
bphon => voc.phonemeNum;

Math.random2f(50,70) => float minfreq;
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



Math.random2(2,9) => int n;
//5 => int n;
string phones[n];
float waits[n];

//["rrr","ooo","aaa","ooo","mmm"] @=>phones;

//Math.random2(1,5) => int m;
2 => int m;
while( m > 0) {
    m - 1 => m;
    allphones[Math.random2(0,allphones.cap()-1)] => phones[0];
    vowels[Math.random2(0,vowels.cap()-1)] => phones[1];
    for ( 0=>int i; i < n ; i+1 => i) {
        if ( i >= 2 ) {
            if ( i % 2 == 0) {
                consonants[Math.random2(0,consonants.cap()-1)] => phones[i];                        
            } else {
                vowels[Math.random2(0,vowels.cap()-1)] => phones[i];                        
            }
        }
        1000*Math.random2(4,21)*0.01449 => waits[i];
        //Math.random2f(50,305) => waits[i];
        <<< phones[i] >>>;
    }
    //["sss","eee","xxx"] @=> string phones[];

    Math.random2(5,30) => int reps;
    Math.random2f( minfreq, minfreq*1.05  ) => voc.freq;
    for ( 0=>int j; j < reps ; j+1 => j) { 

        0 => int index;
        //Math.random2(10,20) => int t;
        phones.cap() => int t;
        <<<j/(1.0*reps)>>>;

        while (t > 0) {
            t - 1 => t;
            phones[index % phones.cap()] => voc.phoneme;
            index + 1 => index;
            Math.random2f( 0.6, 0.8 ) => voc.noteOn;
            //Math.random2( 20, 40 ) => voc.phonemeNum;
            Math.random2f( 0.7, 1.0 ) => voc.voiced;
            Math.random2f( 0.0, 1.0 ) => voc.unVoiced;
            //Math.random2f( minfreq, minfreq*1.05  ) => voc.freq;
            //Math.random2f(0.1,90) => voc.vibratoFreq;
            Math.random2f(0.3,1) => voc.loudness;
            Math.random2f(0,1) => voc.speak;
            //Math.random2f(0,1) => voc.quiet;
            //3 => voc.phonemeNum;
            //Math.random2f(1.0/minfreq,100/minfreq)::ms => now;
            //voc.controlChange(4,0);
            //Math.random2f(50,400)::ms => now;
            waits[index % waits.cap()]::ms => now;
            
        }
        //Math.random2f(300,500)::ms => now;
    }
}
<<<"jam-phrsae done">>>;
Math.random2f(1300,1500)::ms => now;

