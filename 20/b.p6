my @limits = open("input.txt").lines.flatmap: {
  my ($left, $right) = $_.split("-");
  [($left.Int, 1), ($right.Int, -1)]
};

my @sorted = @limits.sort: *[0];
my $open = 0;
my $sum = 0;

for @sorted.kv -> $i, $_ {
  $open += $_[1];
  my $next = @sorted[$i + 1];

  if $open == 0 && $next && $next[0] != $_[0] + 1 {
    $sum += $next[0] - $_[0] - 1;
  }
}

say $sum;
