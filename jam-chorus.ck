JCRev r => dac;
Math.random2(2,5) => int n;
Math.random2( 1, 128 ) => int phonemeNum;

VoicForm voc[n];
for (0 => int i; i < n; i + 1 => i) {
    voc[i] => r;
    Math.random2f(0.2,0.6) => voc[i].gain;
    0.8 => r.gain;
    Math.random2( 1, 128 ) => voc[i].phonemeNum;
    //phonemeNum => voc[i].phonemeNum;
}



Math.random2f(0.1,0.4) => r.mix;
//Math.random2(1,4)*20.0 => float minfreq;
//Math.random2f(30.0,80.0) => float minfreq;
Math.random2f(1180.0,1300.0) => float minfreq;
Math.random2(10,40) => int t;
//Math.random2(60,300) => int t;
t => float maxt;
<<<"Jam Chorus">>>;
<<<minfreq>>>;
<<<t>>>;
while (t > 0) {
    t - 1 => t;
    0.8 * (maxt/2 - Math.fabs(maxt/2 - t))/maxt =>  r.gain;
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
<<<"jam-chorus dies">>>;
<<<minfreq>>>;
