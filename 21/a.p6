my @str = <a b c d e f g h>;

for open("input.txt").lines {
  say @str;

  when m:s/swap position (\d+) with position (\d+)/ {
    @str[$/[0, 1]] = @str[$/[1, 0]];
  }

  when m:s/swap letter (<[a..z]>) with letter (<[a..z]>)/ {
    @str = @str.map: { if $_ eq $/[0] { $/[1].Str } elsif $_ eq $/[1] { $/[0].Str } else { $_ } };
  }

  when m:s/reverse positions (\d+) through (\d+)/ {
    @str = flat @str[0..^$/[0]], @str[$/[0]..$/[1]].reverse, @str[$/[1]^..*];
  }

  when m:s/rotate left (\d+) step/ {
    @str .= rotate($/[0]);
  }

  when m:s/rotate right (\d+) step/ {
    @str .= rotate(-$/[0]);
  }

  when m:s/move position (\d+) to position (\d+)/ {
    @str.splice($/[1].Int, 0, @str.splice($/[0].Int, 1));
  }

  when m:s/rotate based on position of letter (<[a..z]>)/ {
    my $i = @str.first($/[0].Str, :k);
    my $ri = $i + (1, 2)[$i > 3];
    @str .= rotate(-$ri);
  }
}

say @str;
