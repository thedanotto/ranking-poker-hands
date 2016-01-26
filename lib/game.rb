class Game
  require_relative 'hand'
  require_relative 'deck'
  
  attr_accessor :number_of_players, :number_of_cards_per_hand

  def initialize(number_of_players:, number_of_cards_per_hand:)
    @number_of_players = number_of_players
    @number_of_cards_per_hand = number_of_cards_per_hand
  end

  def create_hands
    @hands = Array.new(self.number_of_players) 
    self.number_of_players.times do |num|
      @hands[num] = []
    end
    return @hands
  end
  
  def fill_hands
    prepare_deck
    create_hands
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

  
  def deal_hands

  end

  def evaluate_winner

  end

  def play_hand

  end

  def print_results

  end
end
