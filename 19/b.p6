my @elves = (1506106..3012210).Array.append: 1..1506105;
my $flag = 0;

while @elves.elems > 2 {
  my @collected;

  for @elves {
    if $flag mod 3 == 2 {      
      @collected.push: $_;
    }

    $flag++;
  }
  
  @elves = @collected;
}

say @elves;
