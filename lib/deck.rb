require_relative 'hand'
class Deck
  
  attr_accessor :cards

  def initialize
    @cards = Deck.generate_deck
  end

  def deal_card
    self.cards.shift
  end

  def shuffle
    # this is not functional, but whatever
    self.cards = self.cards.shuffle
  end

  class << self
    def suits
      ["H", "C", "D", "S"]
    end
   
    def card_values
      %w(2 3 4 5 6 7 8 9 T J Q K A)
    end

    def generate_deck
      cards = []
      Deck.suits.each do |suit|
	Deck.card_values.each do |card_value|
	  cards << "#{card_value}#{suit}"
	end
      end
      return cards
    end
  end

end
