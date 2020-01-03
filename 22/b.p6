my @mat = [];

for open("input.txt").lines[2..*] {
  my ($x, $y, $s, $u) = $_ ~~ m:g/\d+/;
  @mat[$y] ||= [];
  @mat[$y][$x] = ".";
  @mat[$y][$x] = "#" if $s > 500;
  @mat[$y][$x] = "_" if $u == 0;
}

@mat[0][* - 1] = "G";

say .join for @mat;
say "";
say @mat.elems, " ", @mat[0].elems;
say "";
say 11 + 30 + 29 + 31 * 5;
