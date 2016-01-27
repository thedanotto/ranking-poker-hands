class Game
  require_relative 'deck'
  require_relative 'hand'
  require_relative 'hand_evaluator'

  attr_accessor :number_of_players, :number_of_cards_per_hand

  def initialize
    @number_of_players = 2
    @number_of_cards_per_hand = 5
  end

  def evaluate_winner(hand1, hand2)
    hand_evaluation = HandEvaluator.new(hand1, hand2)
    
    return hand_evaluation.return_stronger_hand
  end

  def deal_cards(deck)
    hands = [[],[]]
    self.number_of_cards_per_hand.times do |cards|
      self.number_of_players.times do |player|
	hands[player][cards] = deck.deal_card
      end
    end
    
    hand_objects = hands.map do |hand|
      Hand.new(hand)
    end
    return hand_objects
  end

  def play_hand
    deck = shuffled_deck
    hands = deal_cards(deck)
    winning_hand = self.evaluate_winner(hands[0], hands[1])
    losing_hand = winning_hand == hands[0] ? hands[1] : hands[0]
    print_results(winning_hand, losing_hand)
  end

  def shuffled_deck
    deck = Deck.new
    deck.shuffle
    return deck
  end
  
  def print_results(winning_hand, losing_hand)
    puts "The winning hand is a #{winning_hand.hand_type} with the following cards #{winning_hand.cards}"

    puts "The losing hand is a #{losing_hand.hand_type} with the following cards #{losing_hand.cards}"
  end
end
