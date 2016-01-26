class Game
  require_relative 'hand'
  require_relative 'deck'
  
  attr_accessor :number_of_players, :number_of_cards_per_hand

  def initialize(number_of_players:, number_of_cards_per_hand:)
    @number_of_players = number_of_players
    @number_of_cards_per_hand = number_of_cards_per_hand
  end

  def initiate_empty_hands
    @hands = Array.new(self.number_of_players) 
    self.number_of_players.times do |num|
      @hands[num] = []
    end
    return @hands
  end
  
  def fill_hands
    prepare_deck
    initiate_empty_hands
    self.number_of_cards_per_hand.times do |card_num|
      self.number_of_players.times do |num|
	@hands[num][card_num] = @deck.deal_card
      end
    end
    return @hands
  end

  def prepare_deck
    @deck = Deck.new
    @deck.shuffle
    return @deck
  end

  
  def create_hand_objects(hands: self.fill_hands)
    hand_objects = []
    hands.each do |hand|
      hand_objects << Hand.new(hand) 
    end
    return hand_objects
  end

  def evaluate_winner
    hands = self.create_hand_objects
    hand_evaluation = EvaluateHand.new(hands[0], hands[1])
    hand_evaluation.winner
    hand_evaluation.winner_hand
    hand_evaluation.loser
    hand_evaluation.loser_hand
  end

  def play_hand

  end

  def print_results

  end
end
