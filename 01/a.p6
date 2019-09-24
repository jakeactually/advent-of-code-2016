grammar Walk {
    token TOP { <step>+ % ', ' \n }
    token step { <key> <num> }
    token key { L | R }
    token num { \d+ }
}

class WalkActions {
    method TOP ($/) { make (for $<step> { $_.made; }); }
    method step($/) { make ($<key>.Str, $<num>.Int); }
}

my @dirs = (0,1), (-1,0), (0,-1), (1,0);

my $current = 0;
sub move { $current = ($current + $^distance) mod 4 }
sub left { move 3 };
sub right { move 1 };

my @steps := Walk.parsefile("input.txt", actions => WalkActions).made;
my ($x, $y) = 0, 0;

for @steps {
    my ($key, $num) = $_;
    
    if $key eq 'L' {
        left;
    } else {
        right;
    }

    my @increase := @dirs[$current] >>*>> $num;
    $x, $y Z+= @increase;
    
    next;
}

say $x.abs + $y.abs;
