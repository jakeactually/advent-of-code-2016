my $input = "^..^^.^^^..^^.^...^^^^^....^.^..^^^.^.^.^^...^.^.^.^.^^.....^.^^.^.^.^.^.^.^^..^^^^^...^.....^....^.";
my $padded = ".$input.";
my @traps = "..^", "^..", "^^.", ".^^";
my $count = 0;

for 0..38 {
    my $s = "";

    for 0..99 {
        if $padded.substr($_, 3) eq @traps.any {
            $s ~= "^";
        } else {
            $s ~= ".";
            $count++;
        }
    }

    # say $s;
    $padded = ".$s.";
}

say $count + ($input ~~ m:g/\./).elems;
