my $count = 0;
my $regex = /(\w)(\w)$1$0 <?{$0 ne $1}>/;

for lines open 'input.txt' {
  my @parts = $_.split(/\[|\]/);
  my %dic = @parts.pairs.classify(*.key mod 2);
  my @odds := %dic{0}>>.value;
  my @evens := %dic{1}>>.value;
  
  if so (@odds.any & @evens.none) ~~ $regex {
      $count++;
  }
}

say $count;
