my $count = 0;

for open('input.txt').lines.rotor(3) {
    my @matrix = $_.map(&words);

    for 0..2 -> $i {
        my ($a, $b, $c) = (0..2).map: { @matrix[$_][$i] };

        if $a + $b > $c && $a + $c > $b && $b + $c > $a {
            $count++;
        }
    }    
}

say $count;
