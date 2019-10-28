class Swarm {...}

class Message {
  has Bool $.is_output;
  has Int $.recipient;

  method from_match(Match $m --> Message) {
    Message.new:
      :is_output($m[0] eq "output"),
      :recipient($m[1].Int)
  }
}

class Bot {
  has Int $.ID;
  has Swarm $.parent;
  has Int @.vals;
  has Message $!low;
  has Message $!high;

  method insert(Int $value) {
    @.vals.push: $value;
    self.updated;
  }

  method set_messages(Message $low, Message $high) {
    $!low = $low;
    $!high = $high;
    self.updated;
  }

  method updated {
    if @.vals.elems == 2 && $!low && $!high {
      $.parent.exec($!low, @.vals.min);
      $.parent.exec($!high, @.vals.max);
    }
  }
}

class Swarm {
  has Bot @.bots;
  has Int @.output;

  method bot_at(Int $idx --> Bot) {
    if !@.bots[$idx] {
      @.bots[$idx] = Bot.new:
        :parent(self),
        :ID($idx);
    }

    @.bots[$idx]
  }

  method exec(Message $message, Int $data) {
    my $idx = $message.recipient;

    if $message.is_output {
      @.output[$idx] = $data;
    } else {
      self.bot_at($idx).insert: $data;
    }
  }
}

my $swarm = Swarm.new;

for lines open "input.txt" {
  if m/value/ {
    my ($a, $b) = m:g/\d+/>>.Int;
    $swarm.bot_at($b).insert($a);
  } else {
    my ($a, $b, $c) = m:g:s/(output|bot) (\d+)/;
    $swarm.bot_at($a[1].Int).set_messages:
      Message.from_match($b),
      Message.from_match($c);
  }
}

for $swarm.bots {
  say .ID, " ", .vals if .vals.any == (61, 17).all;
}
