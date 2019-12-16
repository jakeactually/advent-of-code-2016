my @elves = 1..3012210;
my $flag = 0;

while @elves.elems > 1 {
  my @collected;

  for @elves {
    if $flag mod 2 == 1 {      
      @collected.push: $_;
    }

    $flag++;
  }
  
  @elves = @collected;
}

say @elves;
