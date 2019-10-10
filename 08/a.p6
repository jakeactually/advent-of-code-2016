my $w = 50;
my $h = 6;
my @matrix = (0 xx $w).Array xx $h;

for lines open 'input.txt' {
  my ($a, $b) = $_ ~~ m:g/\d+/;

  if $_.contains('rect') {
    for 0..^$b -> $y {
      for 0..^$a -> $x {
        @matrix[$y mod $h][$x mod $w] = 1;
      }
    }
  } elsif $_.contains('row') {
    my @row = (for 0..^$w { @matrix[$a][$_]; });

    for 0..^$w {
      @matrix[$a][($_ + $b) mod $w] = @row[$_];
    }
  } else {
    my @column = (for 0..^$h { @matrix[$_][$a]; });

    for 0..^$h {
      @matrix[($_ + $b) mod $h][$a] = @column[$_];
    }
  }
}

say @matrix>>.list.flat.sum;
