fun float logit( float z ) {
    return Math.exp(z)/(1+Math.exp(z));
}

Gain g => dac;

0.8 => g.gain;
//Abstract Buzzer, flies around in space
// and generates audio based on brownian motion
class AbsBuzzer {
    PRCRev p;
    ADSR e;
    0.1 => float stepsize;
    80 => float freqbase;
    0 => float x;
    0 => float y;
    0 => float z;
    0 => float dx;
    0 => float dy;
    0 => float dz;
    fun void stepSize(float ss) {
        stepsize => ss;
    }
    // step function
    fun void step() {
        0.999 * (dy + Std.rand2f(-stepsize,stepsize)) => dy;
        0.999 * (dx + Std.rand2f(-stepsize,stepsize)) => dx;
        0.999 * (dz + Std.rand2f(-stepsize,stepsize)) => dz;
        dy + y => y;
        dx + x => x;
        dz + z => z;
    }    
    fun void build() {
        //SinOsc b => PRCRev p => ADSR e => g;
    }
    fun void setFreq(float freq) {        
    }
    fun void setGain(float gain) {        
    }    
    fun void buzz() {
        while (true) {
            Math.random2f(60,3000)::ms => dur length;            
            0.3 => e.gain;
            0.3 => p.gain;
            length/10 => dur d;
            e.set(d,d,0.25,d);
            setGain(0.3);
            20 + freqbase*(x+1)*(y+1)*(z+1)/(1000*1000*1000)  => float freq;
            setFreq(freq);
            //0.5 + 0.4 * logit(z * x * y) => float mix;
            //0.9 + Math.random2f(0,0.09999) => float mix;
            0.9 + 0.1*logit(z) => float mix;
            p.mix( mix );
            e.keyOn(1);
            9 * d => now;
            e.keyOff(1);
            2 * d => now;
            Std.rand2f(100,3000)::ms => now;
            step();
        }
    }
}
// I wish ChucK's hierarchy was a little more nuanced.
class SinBuzzer extends AbsBuzzer {
    SinOsc sinosc;
    fun void build() {
        sinosc => p => e => g;        
    }
    fun void setFreq(float freq) {
        sinosc.freq(freq);
    }
    fun void setGain(float gain) {
        sinosc.gain(gain);
    }
}
class SqrBuzzer extends AbsBuzzer {
    SqrOsc sinosc;
    fun void build() {
        //sinosc => p => e => g;
        sinosc => p => e => g;        
    }
    fun void setFreq(float freq) {
        sinosc.freq(freq);
    }
    fun void setGain(float gain) {
        sinosc.gain(gain);
    }
}
class PulseBuzzer extends AbsBuzzer {
    PulseOsc sinosc;
    fun void build() {
        sinosc => p => e => g;        
    }
    fun void setFreq(float freq) {
        sinosc.freq(freq);
    }
    fun void setGain(float gain) {
        sinosc.gain(gain);
    }
}
class SawBuzzer extends AbsBuzzer {
    SawOsc sinosc;
    fun void build() {
        sinosc => p => e => g;        
    }
    fun void setFreq(float freq) {
        sinosc.freq(freq);
    }
    fun void setGain(float gain) {
        sinosc.gain(gain);
    }
}
class TriBuzzer extends AbsBuzzer {
    TriOsc sinosc;
    fun void build() {
        sinosc => p => e => g;        
    }
    fun void setFreq(float freq) {
        sinosc.freq(freq);
    }
    fun void setGain(float gain) {
        sinosc.gain(gain);
    }
}



Math.random2(2,10) => int n;
AbsBuzzer @ bz[n];
Std.rand2f(0.01,200) => float mystep;
Math.random2(0,4) => int r;

Math.random2f(-10000,10000) => float bx;
Math.random2f(-10000,10000) => float by;
Math.random2f(-10000,10000) => float bzz;
Math.random2f(10,2000) => float fb;
<<< n, mystep, r, fb, bx, by, bzz >>>;
1 => r;

for (0=>int i; i < n; i + 1 => i) {
    // factory method :/
    //Math.random2(0,4) => int r;

    if (r == 0) {
        new SqrBuzzer @=> bz[i];
    } else if (r == 1) {
        new SinBuzzer @=> bz[i];
    } else if (r == 2) {
        new PulseBuzzer @=> bz[i];
    } else if (r == 3) {
        new SawBuzzer @=> bz[i];
    } else if (r == 4) {
        new TriBuzzer @=> bz[i];
    }
    //Math.random2f(0,10) => float bx;
    //Math.random2f(0,10) => float by;
    //Math.random2f(0,10) => float bzz;

    bz[i].build();
    bz[i].stepSize(mystep);
    bx => bz[i].x;
    by => bz[i].y;
    bzz => bz[i].z;
    //Math.random2f(20,1440) => bz[i].freqbase;
    fb  => bz[i].freqbase;
}
for (0 => int i; i < n ; 1 + i => i) {
    spork ~ bz[i].buzz();
}
Math.random2(5,120) => int t;
while(t > 0) {
    t - 1 => t;
    1000::ms => now;
}

