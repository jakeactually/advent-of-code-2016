my @keyboard = (1..9).rotor(3);
my ($x, $y) = 1, 1;

for lines open 'input.txt' {
    for $_.split('') {
        my @increase = (given $_ {
            when 'D' { 0, 1 if $y < 2 }
            when 'L' { -1, 0 if $x > 0 }
            when 'U' { 0, -1 if $y > 0 }
            when 'R' { 1, 0 if $x < 2 }
            default { () };
        });

        $x, $y Z+= @increase || (0, 0);
    }

    print @keyboard[$y][$x];
}

say '';
