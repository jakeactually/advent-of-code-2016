use Digest::MD5;

my $md5 = Digest::MD5.new;
my @arr;
my $count = 1;

LOOP:
for 0..* {
  my $hex = $md5.md5_hex("ahsbgdzn$_");

  for @arr {
    $_[0]++;
    my $char = $_[1];

    if $hex.contains($char x 5) {
      say $count, " ", $_;
      last LOOP if $count++ == 64;
    }
  }

  @arr.push: [0, $/[0].Str, $_] if $hex ~~ /(.) $0 $0/;
  @arr = @arr.grep: *[0] < 1000;
}
