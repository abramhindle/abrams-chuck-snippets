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
            e.set( length * 1/10, 1/10 * length, 0.5, length/10 );
            setGain(0.5);
            length / 10 => dur attack;
            20 + 1080 * logit(x + y + z) => float freq;
            setFreq(freq);
            0.3 + 5*logit(x + y) => float vibrato;
            0.5 + 0.5 * logit(z - x - y) => float mix;
            p.mix( mix );
            e.keyOn();
            (length * 9 / 10) => now;
            e.keyOff();
            (length * 2 / 10) => now;
            Std.rand2f(10,1000)::ms => now;
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



Math.random2(40,100) => int n;
AbsBuzzer @ bz[n];
Std.rand2f(0.01,20000) => float mystep;
Math.random2(0,4) => int r;

Math.random2f(0,1000) => float bx;
Math.random2f(0,1000) => float by;
Math.random2f(0,1000) => float bzz;
<<< n, mystep, r, bx, by, bzz >>>;
//4 => r;
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
}
for (0 => int i; i < n ; 1 + i => i) {
    spork ~ bz[i].buzz();
}
while(true) {
    1000::ms => now;
}

