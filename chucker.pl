#!/usr/bin/perl
use strict;
use List::Util qw(shuffle);
use Time::HiRes qw(usleep sleep);
sub rm {
    sys("chuck --remove.all");
}
sub add {
    foreach (@_) {
        sys("chuck --add $_");
    }
}
my @l = qw(
    phrase.ck   
chorus.ck
 utter.ck
);
#flutter.ck 


rm();
add(choosen(3));
for (1..4) {
    sleep 1;
    rm();
    add(choosen(3));
}

while(1) {
    sleep 10;
    add($l[rand(@l)]);
}
#while(1) {
#    my @sleeps = (0.01111,0.044444,0.13333,.17777777777777777777,.35555555555555555555);
#    sleep $sleeps[rand(@sleeps)];
#    if (rand() > 0.9) {
#        rm();
#        add(choosen(1));
#    } elsif (rand() > 0.7) {
#        add($l[rand(@l)]);
#    }
#}

sub sys {
    warn @_;
    system(@_);
}
sub choosen {
    my ($n) = @_;
    my @x = shuffle(@l);
    return @x[0..($n-1)];
}
