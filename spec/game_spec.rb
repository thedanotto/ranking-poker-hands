require "spec_helper"
require "game"

describe Game do
  describe "#create_hand_objects" do
    it "should turn the array of hand objects" do
      new_game = Game.new
      hand_objects = new_game.create_hand_objects(hands: [["AH", "AC"], ["QD","5C"]])
      expect(hand_objects.first.cards).to eq(["AH", "AC"])
    end
  end

  describe "#create_hands" do
    it "should create an array with empty arrays equal to the number of players" do
      new_game = Game.new
      
      expect(new_game.initiate_empty_hands).to eq([[],[]])
    end
  end

  describe "#evalute_winner" do
    it "should evaluate the winning hand, given two hands" do
      new_game = Game.new
      higher_hand = Hand.new(["AH", "AC", "AD", "AS", "KH"])
      lower_hand = Hand.new(["2H", "4H", "6D", "8C", "TD"])
      
      expect(new_game.evaluate_winner(higher_hand, lower_hand)).to eq(higher_hand)
    end
  end

  describe "#fill_hands" do
    it "should prepare hands equal to the number of players playing the game" do
      new_game = Game.new

      expect(new_game.fill_hands.count).to eq(2)
    end
  end

  describe "#prepare_deck" do
    it "should create a deck instance and shuffle it" do
      new_game = Game.new
      
      expect(new_game.prepare_deck.cards.length).to eq(52)
    end
  end
end
