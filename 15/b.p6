class Disc {
  has Int $.id;
  has Int $.positions;
  has Int $.current is rw;

  method advance() {
    $.current = ($.current + 1) mod $.positions;
  }

  method dup(--> Disc) {
    Disc.new: :id($.id), :positions($.positions), :current($.current)
  }
}

my @discs = open("input.txt").lines.map: {
  my @ds = ($_ ~~ m:g/\d+/)>>.Int;
  Disc.new: :id(@ds[0]), :positions(@ds[1]), :current(@ds[3])
};

@discs.push: Disc.new: :id(@discs.elems), :positions(11), :current(0);

LOOP:
for 0..* {
  my @copy = @discs>>.dup;
  @discs>>.advance;
  
  for 0..^@discs.elems {
    @copy>>.advance;

    if @copy[$_].current != 0 {
      next LOOP;
    }
  }

  say "yeah $_";
  last;
}
