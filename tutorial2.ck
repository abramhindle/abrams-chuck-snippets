//Impulse i => BiQuad f => dac;
//.99 => f.prad;
// 1 => f.eqzs;
0.0 => float v;
25 => int n;
Impulse is[n];
BiQuad bs[n];
Envelope e[n];
//SinOsc oscarray[n];
//Gain   oscgainarray[5];
for(0 => int i; i<n; i++) {
    //connect to dac
	//oscarray[i] => oscgainarray[i] => dac;
    //oscarray[i] => dac;
    //0.1/n => oscarray[i].gain;
	//Math.pow(2, i) * 110.0 => oscarray[i].freq;
    is[i] => bs[i] => e[i] => dac;
    .99 => bs[i].prad;
    1 => bs[i].eqzs;
    1.0/n => bs[i].gain;
    
}



while( true )
{
    v + .1 => v;
    // set the current sample/impulse
    for(0 => int j; j<n; j++) {
        if (Std.rand2f(0,1) > 0.25) {
            Std.rand2f(0.01,1.0)::ms=>now;
            30::ms => e[j].duration;
            e[j].keyOn();
            1.0 => is[j].next;
            Std.fabs(Math.sin(v)) * Std.rand2f(80,420.0) => bs[j].pfreq;
            Std.rand2f(0.999,0.999999) => bs[j].prad;
        } else {
            if (Std.rand2f(0,1) > 0.9) {
                e[j].keyOff();
            }
        }
	    //Math.pow(2, j) * Std.rand2f(100*v + 110.0,200*v+110.0) => oscarray[j].freq;
    }
    
    // sweep the filter resonant frequency
    // increment v

    // advance time

    //1000*(Std.rand2f(0,3)/Math.exp(3))::ms => now;
    Std.rand2f(100,1000)::ms=>now;
    //Std.rand2f(333,334)::ms=>now;
}
for(0 => int i; i<5; i++) {

	//oscarray[i] =< dac;
	1::second => now;
	
}
