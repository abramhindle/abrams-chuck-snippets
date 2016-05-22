Step s => dac;
100 => int maxsamps;
1000 => int reps;
while(true)
{
	for( 0 => int samps; samps < maxsamps; samps++ ) {
		Std.rand2(-16,16) / 16.0 => s.next;        
        samps::samp => now;   
	}
}
