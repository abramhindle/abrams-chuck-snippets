Step s => dac;
1 => int t => int t16 => int t20 => int x => s.next;
4096 => int m;
1.0*m => float mm;
1 => x;
[666,777,888,111,222,333,0,444] @=> int r[];
// example code at http://countercomplex.blogspot.ca/2011/10/some-deep-analysis-of-one-line-music.html
// http://countercomplex.blogspot.ca/2011/10/algorithmic-symphonies-from-one-line-of.html
// http://wurstcaptures.untergrund.net/music/
while( true ) {
    //128&t&t>>12 => x;
    //t*t>>12 => x;
    //t16*t16>>12 => x;
    //64&t16&t16>>8 => x;
    //t16*t20>>12 + (x*x>>8) + 13  => x;
    //y * t*5&(t>>7)|t*3&(t*4>>10) => x;  
    //(t*(t*(t>>10) + t*(t>>12))) => x;
    //(t*(42&t>>10)) + (t*2*(21&t>>11)) => x;
    //t*(t>>10) => x;
    //t*(((t>>11)|(t>>8)|(t>>13))&(127&(t>>3))) => x;
    r[(t<<10)%8]*t20*((t>>9)|(t>>13))^(4444^(t20>>3)|(t>>5)|(t16>>9)) => x;
    x%m / mm => s.next;
    t + 1 => t;
    t%65536 => t16;
    t%1048576 => t20;
    1::samp => now;
}
