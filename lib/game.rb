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
    hand_evaluation = HandEvaluator.new(hand1, hand2)
    #hand_evaluation.winner
    #hand_evaluation.winner_hand
    #hand_evaluation.loser
    #hand_evaluation.loser_hand
    
    return hand_evaluation.return_stronger_hand
  end

  def play_hand
    hands = self.create_hand_objects
    winning_hand = self.evaluate_winner(hands[0], hands[1])
    losing_hand = winning_hand == hands[0] ? hands[1] : hands[0]
    print_results(winning_hand, losing_hand)
  end

  def print_results(winning_hand, losing_hand)
    
        
    puts "The winning hand is a #{winning_hand.hand_type} with the following cards #{winning_hand.cards}"

    puts "The losing hand is a #{losing_hand.hand_type} with the following cards #{losing_hand.cards}"
  end
end
