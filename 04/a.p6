my $sum = 0;

for lines open 'input.txt' {
    my $hash = $_.substr(0, * - 11).subst("-", "", :g);
    my $id = $_.substr(* - 10, * - 7);
    my $check = $_.substr(* - 6, * - 1);

    my %group = $hash.split("", :skip-empty).classify({ $_ });
    #say %group;

    my %count = %group.map({ $_.key => $_.value.elems });
    #say %count;

    my %by-count = %count.classify(*.value);
    #say %by-count;

    my %count-string = %by-count.map({ $_.key => %($_.value).keys.sort });
    #say %count-string;

    my @sorted = %count-string.sort(*.key).reverse().map(*.value);
    
    if @sorted>>.List.flat.head(5).join eq $check {
        $sum += $id;
    }
}

say $sum;
