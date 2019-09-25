my $keyboard = q:to/END/;
       
   1   
  234  
 56789 
  ABC  
   D   
       
END

my @keyboard = $keyboard.lines.map: *.split('', :skip-empty);
my ($x, $y) = 1, 3;

for lines open 'input.txt' {
    for $_.split('') {
        my ($px, $py) = $x, $y;

        my @increase = (given $_ {
            when 'D' { 0, 1 }
            when 'L' { -1, 0 }
            when 'U' { 0, -1 }
            when 'R' { 1, 0 }
            default { () };
        });

        $x, $y Z+= @increase || (0, 0);

        if @keyboard[$y][$x] eq ' ' {
            ($x, $y) = ($px, $py);
        }
    }

    print @keyboard[$y][$x];
}

say '';
