use NativeCall;
sub md5_(Str, CArray[uint8]) is native('./libmd5.so') { * }

my $array = CArray[uint8].new((0..32).list);

my $i = 0;
my $c = 0;
my $prefix = "uqwqemis";
my $pass;

loop {
    my $test = "$prefix$i";

    if $i mod 10000 == 0 {
        say $test;
    }

    md5_($test, $array);
    my $check = $array.list.chrs.substr(0, 5);

    if $check eq "00000" {
        say $i;
        $pass ~= $array[5].chrs;
        $c++;
    }

    if $c > 7 {
        last;
    }

    $i++;
}

say $pass;
