JCRev r => dac;
Math.random2(2,10) => int n;
Math.random2( 1, 128 ) => int phonemeNum;

VoicForm voc[n];
for (0 => int i; i < n; i + 1 => i) {
    voc[i] => r;
    0.5 => voc[i].gain;
    0.8 => r.gain;
    phonemeNum => voc[i].phonemeNum;
}



Math.random2f(0.1,0.4) => r.mix;
//Math.random2(1,4)*20.0 => float minfreq;
//Math.random2f(30.0,80.0) => float minfreq;
Math.random2f(20.0,30.0) => float minfreq;
//Math.random2(10,120) => int t;
600 => int t;

<<<minfreq>>>;
<<<t>>>;
Math.random2f(20,40) => float minfreq;
Math.random2(10,100) => int t;
while (t > 0) {
    t - 1 => t;
    for ( 0 => int i ; i < n ; i + 1 => i) {
        Math.random2f( 0.6, 0.8 ) => voc[i].noteOn;
        
        Math.random2f( 0.9, 1.0 ) => voc[i].voiced;
        Math.random2f( 0.0, 1.0 ) => voc[i].unVoiced;
        Math.random2f( minfreq, minfreq*1.05  ) => voc[i].freq;
        Math.random2f(0.1,90) => voc[i].vibratoFreq;
        Math.random2f(0.3,1) => voc[i].loudness;
        Math.random2f(0,1) => voc[i].speak;
    }
    Math.random2f(100,1500)::ms => now;
        
}
<<<"chorus dies">>>;
<<<minfreq>>>;
