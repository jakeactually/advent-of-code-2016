use NativeCall;
sub hash(CArray[uint8], CArray[uint8]) is native('./libhash.so') { * }

use experimental :pack;

my @arr;
my $count = 1;

LOOP:
for 0..* {
  my $hex = hashw("ahsbgdzn$_");

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

sub hashw(Str $str --> Str) {
    my $in = CArray[uint8].new($str.encode.list);    
    my $out = CArray[uint8].new(0 xx 16);
    hash($in, $out);
    Blob.new($out).unpack("H*")
}
