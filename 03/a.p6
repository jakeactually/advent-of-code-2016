my $count = 0;

for lines open 'input.txt' {
    my ($a, $b, $c) = $_.words;

    if $a + $b > $c && $a + $c > $b && $b + $c > $a {
        $count++;
    }
}

say $count;
