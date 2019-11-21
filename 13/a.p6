my $size = 40;
my Int %set;
my $input = 1364;

for 0..$size X 0..$size -> ($x, $y) {
  my $n = ($x*$x + 3*$x + 2*$x*$y + $y + $y*$y) + $input;
  my $bits = (0..15).map: $n +> * +& 1;

  if $bits.sum mod 2 {    
    %set{$($x, $y)} = -1;
  }
}

sub out(($x, $y)) {
  (($x + 1, $y) if $x < $size),
  (($x - 1, $y) if $x > 0),
  (($x, $y + 1) if $y < $size),
  (($x, $y - 1) if $y > 0)
}

my @walkers = (1, 1),;
my $dist = 1;

while @walkers {
  @walkers = @walkers.map(&out)>>.Array.flat.grep: { !%set{$_} };

  if @walkers.any eq (31, 39) {
    say $dist;
    last;
  }

  %set{$_} = $dist for @walkers;
  $dist++;
}
