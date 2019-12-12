sub fill(Str $initial, Int $dst --> Str) {
    my $buff = $initial;

    while $buff.chars < $dst {
        my $a = $buff;
        my $b = S:g/(\d)/{ ($0 eq "0").Int }/ given $buff.flip;
        $buff = "{$a}0{$b}";
    }

    $buff.substr(0, $dst)
}

sub checksum(Str $input) {
    my $buff = $input;

    while $buff.chars mod 2 == 0 {
        $buff = S:g/(\d)(\d)/{ ($0 eq $1).Int }/ given $buff;
    }

    $buff
}

say checksum(fill("01000100010010111", 272))
