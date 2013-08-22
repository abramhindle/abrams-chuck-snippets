fun float logit( float z ) {
    return Math.exp(z)/(1+Math.exp(z));
}

Gain g => dac;

class AbsBuzzer {
    PRCRev p;
    ADSR e;

    0 => float x;
    0 => float y;
    0 => float z;
    0 => float dx;
    0 => float dy;
    0 => float dz;

    fun void step() {
        0.999 * (dy + Std.rand2f(-0.1,0.1)) => dy;
        0.999 * (dx + Std.rand2f(-0.1,0.1)) => dx;
        0.999 * (dz + Std.rand2f(-0.1,0.1)) => dz;
        dy + y => y;
        dx + x => x;
        dz + z => z;
    }    
    fun void build() {
        //getOscillator() => p => e => g;
        //SinOsc b => PRCRev p => ADSR e => g;
    }
    fun void setFreq(float freq) {        
    }
    fun void setGain(float gain) {        
    }    
    fun void buzz(dur length) {
        0.3 => e.gain;
        e.set( length * 1/10, 1/10 * length, 0.5, length/10 );
        setGain(0.5);
        length / 10 => dur attack;
        40 + 440 * logit(x + y + z) => float freq;
        setFreq(freq);
        0.3 + 5*logit(x + y) => float vibrato;
        0.5 + 0.5 * logit(z - x - y) => float mix;
        p.mix( mix );
        e.keyOn();
        (length * 9 / 10) => now;
        e.keyOff();
        (length * 2 / 10) => now;

    }
}
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



50 => int n;
AbsBuzzer @ bz[n];
for (0=>int i; i < n; i + 1 => i) {
    Math.random2(0,3) => int r;    
    if (r == 0) {
        new SqrBuzzer @=> bz[i];
    } else if (r == 1) {
        new SinBuzzer @=> bz[i];
    } else if (r == 2) {
        new PulseBuzzer @=> bz[i];
    } else if (r == 3) {
        new SawBuzzer @=> bz[i];
    }
    bz[i].build();
}


while(true) {
    for (0 => int i; i < n ; 1 + i => i) {
        bz[i].step();
        spork ~ bz[i].buzz(Std.rand2f(100,1000)::ms);
        //Std.rand2f(0,3)::ms => now;
    }
    Std.rand2f(10,100)::ms => now;
}
