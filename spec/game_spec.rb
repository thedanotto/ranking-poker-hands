require "spec_helper"
require "game"

describe Game do
  describe "#create_hands" do
    it "should create an array with empty arrays equal to the number of players" do
      new_game = Game.new(number_of_players: 2, number_of_cards_per_hand: 5)
      
      expect(new_game.initiate_empty_hands).to eq([[],[]])
    end
  end

  describe "#fill_hands" do
    it "should prepare hands equal to the number of players playing the game" do
      new_game = Game.new(number_of_players: 2, number_of_cards_per_hand: 5)

      expect(new_game.fill_hands.count).to eq(2)
    end
  end

  describe "#prepare_deck" do
    it "should create a deck instance and shuffle it" do
      new_game = Game.new(number_of_players: 2, number_of_cards_per_hand: 5)
      
      expect(new_game.prepare_deck.cards.length).to eq(52)
    end
  end
end
