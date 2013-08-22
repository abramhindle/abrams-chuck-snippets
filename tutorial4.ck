//Impulse i => BiQuad f => dac;
//.99 => f.prad;
// 1 => f.eqzs;
0.0 => float v;
1 => int n;
Impulse is[n];
BiQuad bs[n];

//SinOsc oscarray[n];
//Gain   oscgainarray[5];
for(0 => int i; i<n; i++) {
    //connect to dac
	//oscarray[i] => oscgainarray[i] => dac;
    //oscarray[i] => dac;
    //0.1/n => oscarray[i].gain;
	//Math.pow(2, i) * 110.0 => oscarray[i].freq;
    is[i] => bs[i] =>  dac;
    .99 => bs[i].prad;
    1 => bs[i].eqzs;
    0.3/n => bs[i].gain;
    
}



while( true )
{
    v + .1 => v;
    // set the current sample/impulse
    for(0 => int j; j<n; j++) {
        Std.rand2f(0.01,1.0)::ms=>now;
        0.3 => is[j].next;
        20 + (Std.fabs(Math.sin(v)) * Std.rand2f(20,120.0)) => bs[j].pfreq;
        Std.rand2f(0.9995,0.99999) => bs[j].prad;
        //0 => bs[j].gain;
        //30::ms=>now;
        //0.6/n => bs[j].gain;
    }
    
    
    Std.rand2f(1333,1341)::ms=>now;
}
