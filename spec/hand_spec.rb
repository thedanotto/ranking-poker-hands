require "spec_helper"
require "hand"

describe Hand do
  # all the tests for the hand
  describe "#is_a_hand?" do
    it "a collection of 5 cards should be a hand" do
      hand = Hand.new(["AS", "KD", "QH", "JC", "TD"])
    
      expect(hand.valid_hand?).to eq(true)
    end

    it "returns false when less than 5 cards are supplied" do
      hand = Hand.new("")

      expect(hand.valid_hand?).to eq(false)
    end
  end

  describe "#suits" do
    it "should parse the suits of the hand" do
      hand = Hand.new(["AS", "KD", "QH", "JC", "TD"])

      expect(hand.suits).to eq(["S", "D", "H", "C", "D"])
    end
  end

  describe "#card_values" do
    it "should parse the card value" do
      hand = Hand.new(["AS", "TD", "QH"])

      expect(hand.card_values).to eq(["A", "T", "Q"])
    end
  end
end
