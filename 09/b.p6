say length trim slurp 'input.txt';

sub length(Str $text --> Int) {
  my @children = $text ~~ m:g/ \((\d+)x(\d+)\) {} :my $c = $0; (. ** { $c }) /;

  if @children {
    my $rest = $text.chars - @children>>.chars.sum;
    $rest + @children.map({ $_[1] * length($_[2].Str) }).sum
  } else {
    $text.chars
  }
}
