class Item {
  has Int $.level;
  has Str $.element;
  has Bool $.is_microchip;

  method init(Int $level, Str $element, Bool $is_microchip --> Item) {
    Item.new:
      :level($level),
      :element($element),
      :is_microchip($is_microchip)
  }

  method up {
    Item.init($.level + 1, $.element, $.is_microchip);
  }

  method down {
    Item.init($.level - 1, $.element, $.is_microchip);
  }

  method is_fried_by(Item $item --> Bool) {
    self.element ne $item.element &&
    self.level eq $item.level &&
    !$item.is_microchip 
  }

  method is_powered_by(Item $item --> Bool) {
    self.element eq $item.element &&
    self.level eq $item.level &&
    !$item.is_microchip
  }
}

class Status {
  has Item @.items;
  has Int $.elevator;

  method init(Item @items, Int $elevator) {
    Status.new:
      :items(@items),
      :elevator($elevator)
  }

  method code(--> Str) {
    $.elevator ~ "-" ~
    @.items
      .classify(*.element)
      .map(*.value.sort(*.is_microchip).map(*.level).join)
      .sort
      .join("-")
  }

  method valid(--> Bool) {
    my @generators = @.items.grep: !*.is_microchip;

    so @.items
      .grep({ $_.is_microchip && $_.is_fried_by(@generators.any) })
      .all.is_powered_by(@generators.any)
  }

  method is_goal(--> Bool) {
    so @.items.all.level == 4
  }

  method up(Int @is --> Status) {
    my Item @items = @.items.clone;
    @items[$_] .= up for @is;
    Status.init: @items, $.elevator + 1
  }

  method down(Int @is --> Status) {
    my Item @items = @.items.clone;
    @items[$_] .= down for @is;
    Status.init: @items, $.elevator - 1
  }

  method out(--> Array[Status]) {
    my @indexes = @.items.pairs
      .grep(*.value.level == $.elevator)
      .map(*.key);

    my $min = @.items>>.level.min;
    
    Array[Status].new: gather {
      for @indexes.combinations: 1..2 {
        if $.elevator < 4 {
          take self.up: Array[Int].new: $_;
        }

        if $.elevator > $min {
          take self.down: Array[Int].new: $_;
        }
      }
    }
  }
}

class Walker {
  has Status $.status;
  has Int $.steps;

  method init(Status $status, Int $steps) {
    Walker.new:
      :status($status),
      :steps($steps)
  }

  method code(--> Str) {
    $.status.code
  }

  method out(--> Array[Walker]) {
    Array[Walker].new: $.status.out.map: {
      Walker.init: $_, $.steps + 1
    }
  }
}

my Item @items = gather {
  for kv lines open "input.txt" -> $i, $_ {
    for m:g:s/(\w)\w+\-(c)|(\w)\w+ (g)/ {
      take Item.init: $i + 1, $_[0].Str, $_[1] eq "c";
    }
  }
};

my $status = Status.init: @items, 1;
my $walker = Walker.init: $status, 0;
my @walkers = $walker;
my %visited;

while @walkers {
  @walkers = @walkers>>.out>>.list.flat
    .classify(*.code)
    .map(*.value.first)    
    .grep({ !%visited{$_.code} && $_.status.valid });

  say @walkers>>.code;
  %visited (|)= @walkers>>.code;

  if my $goal = @walkers.first: *.status.is_goal {
    say $goal;
    last;
  }
}
