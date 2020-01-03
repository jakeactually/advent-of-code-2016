my $count = 0;

my @pairs = open("input.txt").lines[2..*].map: {
  my ($s, $u, $a) = $_[0] ~~ m:g/(\d+)T/;
  $u[0].Int, $a[0].Int
};

for @pairs.combinations(2) {
  if $_[0][0] != 0 && $_[0][0] < $_[1][1] {
    $count++;
  }
  if $_[1][0] != 0 && $_[1][0] < $_[0][1] {
    $count++;
  }
}

say $count;
