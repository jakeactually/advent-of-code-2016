use Digest::MD5;

my $i = 0;
my $c = 0;
my $input = "abc";
my $pass;

my $d = Digest::MD5.new;

loop {
    my $test = "$input$i";

    if $i mod 1000 == 0 {
        say $test;
    }

    my $hash = $d.md5_buf($test);
    my $check = $hash.substr(0, 5);

    if $check eq "00000" {
        say $i;
        $pass += $hash[5];
        $c++;
    }

    if $c > 8 {
        last;
    }

    $i++;
}

say $pass;
