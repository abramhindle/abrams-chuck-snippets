Step s => dac;
1 => int i => int x => int t => int t16 => s.next;
[1,1,1,1,1] @=> int y[];
256 => int m;
1 => int samps;
//256 => int m;
1.0 * m => float mm;
0.0 => float out;

fun int[] z1()
{
    return [Std.rand2(1,16), Std.rand2(1,16),Std.rand2(1,256) ,Std.rand2(1,16),Std.rand2(1,16) ,Std.rand2(1,12)];
} 

fun int[][] zgen()
{
    return [ z1(),z1(),z1(),z1(),z1()];
    
}

zgen() @=> int z[][];

while(true)
{
    for( 0 => int j; j < 44100; j++ )
    {
         0.0 => out;
         //t*t&t>>12 => x;
         //t*(((t>>10)|(t>>8)|(t>>12))|(29&((t>>16)|(t16>>11)))) => x;
         //t*(((t>>4)|(t>>7)|(t>>13)^(t*t>>9))|(125&((t>>12)|(t16>>5)))) => x;
         //1+(t*t>>5 + x&x>>3 - x*x&x>>5)*t>>3 => x;
         for( 0 => int i; i < y.cap(); i++ )
         {    
             t16*((t>>z[i][0])|(t>>z[i][1]))^(z[i][2]&((t16>>z[i][3])|(t>>z[i][4]))) << z[i][5] => y[i];
         }
         //t*(((t>>3)|(t>>2)|(t>>7)^(t*t>>9))^(234&(t>>7)|(t>>1))) << 10 => y[0];
         //t*(((t>>7)|(t>>5)|(t>>8)^(t*t>>9))^(200&(t>>6)|(t>>2))) << 6 => y[1];
         //t*(((t>>9)|(t>>7)|(t>>13)^(t*t>>9))^(197&(t>>5)|(t>>3))) << 7 => y[2];
         //t16*(((t>>4)|(t>>3)|(t>>12)^(t*t>>9))^(168&(t>>4)|(t>>4))) << 8 => y[3];
         //t16*(((t>>4)|(t>>7)|(t>>13)^(t*t>>9))^(127&(t>>3)|(t>>5))) << 9 => y[4];
         //(t>>2)&1 => x;
         1 => int mul;
         for( 0 => int i; i < y.cap(); i++ )
         {
             if (i % 2 == 0)
             {
                 -1 => mul;
             }
             else
             {
                 1 => mul;
             }
             out + mul*(y[i]%m/mm) => out;
         }
         out => s.next;
         t + 1 => t;
         t % 65535 => t16;
         samps::samp => now;    
     }
     z1() @=> z[Std.rand2(0,4)] ;
     //zgen() @=> int z[][];
}
