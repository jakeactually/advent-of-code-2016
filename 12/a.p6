class Token {
  has Str $.reg;
  has Int $.raw;

  method from_string(Str $str --> Token) {
    if $str ~~ /\d+/ {
      Token.new: :raw($str.Int)
    } else {
      Token.new: :reg($str)
    }
  }

  method val(Int %regs --> Int) {
    if $.reg {
      %regs{$.reg}
    } else {
      $.raw
    }
  }
}

class Instruction {
  has Str $.tag;
  has Token $.left;
  has Token $.right;
}

my @instructions = gather {
  for lines open "input.txt" {
    my ($tag, $left, $right) = .split(" ", :skip-empty);

    take Instruction.new:
      :tag($tag)
      :left(Token.from_string: $left || ""),
      :right(Token.from_string: $right || "");
  }
};

my $pointer = 0;
my Int %regs = <a b c d>.map: * => 0;

loop {
  last if $pointer >= @instructions.elems;
  my $instruction = @instructions[$pointer];
  
  given $instruction.tag {    
    when "cpy" {
      %regs{$instruction.right.reg} = $instruction.left.val(%regs);
    }

    when "inc" { %regs{$instruction.left.reg}++; }
    when "dec" { %regs{$instruction.left.reg}--; }

    when "jnz" {
      if $instruction.left.val(%regs) != 0 {
        $pointer += $instruction.right.val(%regs);
        next;
      }
    }
  }

  $pointer++;
}

say %regs;
