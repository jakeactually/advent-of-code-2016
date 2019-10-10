my $count = 0;

for lines open 'input.txt' {
  my @parts = $_.split(/\[|\]/);
  my %dic = @parts.pairs.classify(*.key mod 2);
  my @odds := %dic{0}>>.value;
  my @evens := %dic{1}>>.value;
  
  my @abas = @odds.flatmap({ $_ ~~ m:overlap/(\w)(\w)$0 <?{$0 ne $1}>/ });

  if @evens.any.contains(toBAB(@abas.any)) {
    $count++;
  }
}

say $count;

sub toBAB(Match $match --> Str) {
  my ($a, $b) = $match.split('', :skip-empty);
  return "$b$a$b";
}
