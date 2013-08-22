Step s => dac;
1 => int t => int t16 => int t20 => int x => int y => s.next;
256 => int m;
1.0*m => float mm;
1 => x;
while( true ) {
    //t>>6 => x;
    //t ^ (t>>5 | t*t>>7 | 127&t*t>>10 | 6 *(t+3)) =>x;
    //(t%8)&(t * 4 | t * 16 | (t+3)*7) => x;
    //1 => y;
    //8&t16*t20>>12 | (t<<7 % 2)^(127&t>>3) |(t<<6 % 2)^(127&t>>5) | (66&t>>2) => x;
    //(t << 8)%2 *( x << 3 * ((y * 78) % 5)) => y;
    t& ((t*t << 9)%2 * t*t>>2 | t*2 | t>>5 | t>>3 | t*6 | t*t*19 | (127 & t * 62))=> x;
    //-6*y*t16 => y;//t*t16*(t * 3 | t * ((t<<5%2)+9) | t * 16) => y;
    //(y * (y << 5)) * t => x;
    //(1 + (((t>>7) | (t>>5)) | (63&(t16>>5)|(t*t>>3)))) => x;
    //t16 ^ (1 + (((t<<8) | (t>>9)) | (63&(t16>>5)|(t*t>>3)))) => y;
    //99&(t>>5) | 77 * t * t >> 3 => y;
    199&t16*t*t>>13=>y;
    //99&(t>>(((t<<5)%2) + 5)) | 77 * t * t >> 3 => y;
    //128&t&t>>12 => x;
    //(1+x)*t&(t*7)>>9 => x;
    //(1+x)*t16&(t*7)>>13 => x;
    //t16*t>>4 => x;
    //t*t>>12 => x;
    //t16*t16>>9 => x;
    //64&t16&t16>>8 => x;
    //t16*t20>>12 + (x*x>>8) + 13  => x;
    //y * t*5&(t>>7)|t*3&(t*4>>10) => x;  
    //(t*(t*(t>>10) + t*(t>>12))) => x;
    //(t*(42&t>>10)) + (t*2*(21&t>>11)) => x;
    //t*(t>>10) => x;
    //t*(((t>>11)|(t>>8)|(t>>13))&(127&(t>>3))) => x;
    //r[(t<<10)%8]*t20*((t>>9)|(t>>13))^(4444^(t20>>3)|(t>>5)|(t16>>9)) => x;
    x%m / mm - y%m/mm => s.next;
    t + 1 => t;
    t%65536 => t16;
    t%1048576 => t20;
    1::samp => now;
}
// example code at http://countercomplex.blogspot.ca/2011/10/some-deep-analysis-of-one-line-music.html
// http://countercomplexb.blogspot.ca/2011/10/algorithmic-symphonies-from-one-line-of.html
// http://wurstcaptures.untergrund.net/music/
