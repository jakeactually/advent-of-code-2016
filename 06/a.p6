my $matrix = open('input.txt').lines.map: *.split('', :skip-empty);
#say $matrix;

my $transposed = roundrobin $matrix;
#say $transposed;

my @groups = $transposed.map: *.classify({ $_ });
#say @groups;

my @maxs = @groups.map: *.max(*.value.elems).key;
say @maxs.join;
