require "spec_helper"
require "deck"

describe Deck do
  describe "Deck.new" do
    it "should come with 52 cards" do
      new_deck = Deck.new

      expect(new_deck.cards.length).to eq(52)
    end
    
    it "should contain the AH" do
      new_deck = Deck.new

      expect(new_deck.cards).to include("AH")
    end
  end

  describe "#deal_card" do
    it "should lower the deck by 1" do
      new_deck = Deck.new
      initial_card_count = new_deck.cards.length

      new_deck.deal_card

      expect(initial_card_count).to eq(new_deck.cards.length + 1)
    end

    it "should return the first in the array" do
      new_deck = Deck.new
      expected_card_to_be_dealt = new_deck.cards[0]

      expect(new_deck.deal_card).to eq(expected_card_to_be_dealt)
    end
  end

  describe "#shuffle" do
    it "should randomizes the order of the deck, except in the rare case that a shuffled deck doesn't shuffle the cards at all" do
      new_deck = Deck.new
      unshuffled_cards = new_deck.cards
      
      new_deck.shuffle
      shuffled_cards = new_deck.cards

      expect(unshuffled_cards == shuffled_cards).to eq(false)
    end
  end

  # class << self methods
  describe "#card_values" do
    it "should include alll the card_values in a deck" do
      expect(Deck.card_values.length).to eq(13)
      expect(Deck.card_values).to include("2")
      expect(Deck.card_values).to include("3")
      expect(Deck.card_values).to include("4")
      expect(Deck.card_values).to include("5")
      expect(Deck.card_values).to include("6")
      expect(Deck.card_values).to include("7")
      expect(Deck.card_values).to include("8")
      expect(Deck.card_values).to include("9")
      expect(Deck.card_values).to include("T")
      expect(Deck.card_values).to include("J")
      expect(Deck.card_values).to include("Q")
      expect(Deck.card_values).to include("K")
      expect(Deck.card_values).to include("A")
    end
  end

  describe "#suits" do
    it "should be include all the suits available in a deck" do
      expect(Deck.suits.length).to eq(4)
      expect(Deck.suits).to include("H")
      expect(Deck.suits).to include("D")
      expect(Deck.suits).to include("C")
      expect(Deck.suits).to include("S")
    end
  end

  describe "#generate_deck" do
    it "should create 52 cards" do
      expect(Deck.generate_deck.length).to eq(52)
    end

    it "should contain the TC" do
      expect(Deck.generate_deck).to include("TC")
    end
  end
end
