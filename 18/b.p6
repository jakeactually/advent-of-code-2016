my $input = "^..^^.^^^..^^.^...^^^^^....^.^..^^^.^.^.^^...^.^.^.^.^^.....^.^^.^.^.^.^.^.^^..^^^^^...^.....^....^.";
my $count = ($input ~~ m:g/\./).elems;

my @padded;
@padded.push: True;
@padded.append: $input.split("", :skip-empty).map: * eq ".";
@padded.push: True;

for 2..400000 {
    my ($a, $b, $c) = (@padded[0], @padded[1], @padded[2]);

    for 1..100 {
        if ($a ^ $b) ^ ($b ^ $c) {
            @padded[$_] = False;
        } else {
            @padded[$_] = True;
            $count++;
        }

        $a = $b;
        $b = $c;
        $c = @padded[$_ + 2];
    }

    say "$_ $count" if $_ mod 100 == 0;
}
