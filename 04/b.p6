for lines open 'input.txt' {
    my $hash = $_.substr(0, * - 11).subst("-", "", :g);
    my $id = $_.substr(* - 10, * - 7);
    
    print "$id ";
    say $hash.ords.map({ ($_ - 97 + $id) mod 26 + 97 }).chrs
}
