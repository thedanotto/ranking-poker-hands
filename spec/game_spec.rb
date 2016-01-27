require "spec_helper"
require "game"

describe Game do
  describe "#evalute_winner" do
    it "should evaluate the winning hand, given two hands" do
      new_game = Game.new
      higher_hand = Hand.new(["AH", "AC", "AD", "AS", "KH"])
      lower_hand = Hand.new(["2H", "4H", "6D", "8C", "TD"])
      
      expect(new_game.evaluate_winner(higher_hand, lower_hand)).to eq(higher_hand)
    end
  end

  describe "#deal_cards" do
    it "deals two hands" do
      game = Game.new
      deck = game.shuffled_deck

      expect(game.deal_cards(deck).length).to eq(2)
    end

    it "deals 5 cards to each hand" do
      game = Game.new
      deck = Deck.new

      expect(game.deal_cards(deck)[0].cards.length).to eq(5)
      expect(game.deal_cards(deck)[1].cards.length).to eq(5)
    end
  end

  describe "#shuffled_deck" do
    it "should create a deck instance and shuffle it" do
      new_game = Game.new
      
      expect(new_game.shuffled_deck.cards.length).to eq(52)
    end
  end
end
