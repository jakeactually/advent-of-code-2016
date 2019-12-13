use Digest::MD5;

my $md5 = Digest::MD5.new;
my $regex = /b|c|e|d|f/;

my $x = 0;
my $y = 0;

sub out(Str $current, Int $x, Int $y --> List) {
    my $hex = $md5.md5_hex($current).split("", :skip-empty);

    (("{$current}U", $x, $y - 1) if $hex[0] ~~ $regex && $y > 0),
    (("{$current}D", $x, $y + 1) if $hex[1] ~~ $regex && $y < 3),
    (("{$current}L", $x - 1, $y) if $hex[2] ~~ $regex && $x > 0),
    (("{$current}R", $x + 1, $y) if $hex[3] ~~ $regex && $x < 3)
}

my @walkers = ("hhhxzeay", 0, 0);

while @walkers {
    @walkers = @walkers.flatmap(&out);
    say @walkers;

    for @walkers.rotor(3) {
        if $_[(1, 2).all] == 3 {
            say $_;
            exit;
        }
    }
}
