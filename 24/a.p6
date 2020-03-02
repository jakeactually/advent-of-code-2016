class Point {
    has $.x;
    has $.y;

    method code {
        "$.x,$.y"
    }
}

my @matrix = open('input.txt').lines>>.split('', :skip-empty);
my %set;

sub directions(Point $point --> Array[Point]) {
    Array[Point].new:
        Point.new(y => $point.y + 1, x => $point.x),
        Point.new(y => $point.y - 1, x => $point.x),
        Point.new(y => $point.y, x => $point.x + 1),
        Point.new(y => $point.y, x => $point.x - 1)
}

sub point_out(Point $point --> Array[Point]) {
    Array[Point].new:
        directions($point).grep: {
            @matrix[$_.y][$_.x] ne '#'
        }
}

sub out(Point @points --> Array[Point]) {
    Array[Point].new: @points.flatmap: &point_out
}

my Point @points = Point.new(y => 3, x => 5);
my %goal_set = '0' => True;
my $steps = 0;

say 0;

loop {
    # say @points>>.code;

    @points = out(@points)
        .classify({ $_.code })
        .map({ $_.value[0] })
        .grep({ !%set{$_.code} });

    %set (|)= @points>>.code;

    my $goal = @points.first: {
        my $char = @matrix[$_.y][$_.x];
        $char ne '.' && !%goal_set{$char}
    };

    if $goal {
        my $char = @matrix[$goal.y][$goal.x];
        say $char;
        %goal_set{$char} = True;

        @points = Array.new: $goal;
        %set := {};

        last if %goal_set.elems >= 8;
    }

    $steps++;
}

say $steps + 1;
