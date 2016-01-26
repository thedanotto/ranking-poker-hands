class Game
  require_relative 'deck'
  require_relative 'hand'
  require_relative 'hand_evaluator'

  attr_accessor :number_of_players, :number_of_cards_per_hand

  def initialize(number_of_players: 2, number_of_cards_per_hand: 5)
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

  def evaluate_winner(hand1, hand2)
    # I want to decouple this from creating the hand objects
    # I want to pass in the hand objects
    hands = self.create_hand_objects
    hand_evaluation = HandEvaluator.new(hands[0], hands[1])
    #hand_evaluation.winner
    #hand_evaluation.winner_hand
    #hand_evaluation.loser
    #hand_evaluation.loser_hand
    "Player 1 wins"
  end

  def play_hand
    hands = self.create_hand_objects
    self.evaluate_winner(hands[0], hands[1])
  end

  def print_results

  end
end
