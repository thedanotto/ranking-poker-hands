class Hand
  attr_accessor :cards
  
  def initialize(cards)
    @cards = cards
    @number_of_cards = 5
  end

  def valid_hand?
    self.cards.length == 5
  end

  def suits
    suits = []
    self.cards.each do |card|
      suits << card[1]
    end
    return suits
  end

  def card_values
    values = []
    self.cards.each do |card|
      values << card[0]
    end
    return values
  end
end
