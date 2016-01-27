# Play Poker, by yourself, in Ruby.

<a href="https://asciinema.org/a/7ap5p54bq8maaxi79bejzsj2f">See it in action!</a>


Here's how...

    $ git clone https://github.com/thedanotto/ranking-poker-hands.git
    $ cd ranking-poker-hands
    $ bin/setup
    $ irb
    > load 'lib/game.rb'
      => true
    > Game.new.play_hand
      The winning hand is a pair with the following cards ["JS", "TH", "8S", "6H", "6C"]
      The losing hand is a pair with the following cards ["7D", "QD", "3D", "3H", "9H"]


