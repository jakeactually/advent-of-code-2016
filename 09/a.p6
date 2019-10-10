given trim slurp 'input.txt' {
  say S:g/ \((\d+)x(\d+)\) {} :my $c = $0; (. ** { $c }) /{ $2 x $1 }/.chars;
}
