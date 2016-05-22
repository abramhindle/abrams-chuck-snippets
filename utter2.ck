VoicForm voc => JCRev r => dac;
0.5 => voc.gain;
0.5 => r.gain;
while(true) {
    Math.random2f(0.1,0.4) => r.mix;
    Math.random2f(140,1180) => float minfreq;
    Math.random2( 1, 128 ) => voc.phonemeNum;
    Math.random2(10,1000) => int n;
    while (n > 0) {
        n - 1 => n;
        Math.random2f( 0.6, 0.8 ) => voc.noteOn;
        Math.random2f( 0.9, 1.0 ) => voc.voiced;
        Math.random2f( 0.0, 1.0 ) => voc.unVoiced;
        Math.random2f( minfreq, minfreq*1.05  ) => voc.freq;
        Math.random2f(0.1,90) => voc.vibratoFreq;
        Math.random2f(0.3,1) => voc.loudness;
        Math.random2f(0,1) => voc.speak;
        Math.random2f(100,1500)::ms => now;
        
    }
}
