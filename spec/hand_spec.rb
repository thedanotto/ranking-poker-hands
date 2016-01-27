require "spec_helper"
require "hand"

describe Hand do
  def cards(hand_type)
    available_hands = {
      straight_flush: %w(9S TS 8S 7S JS),
      four_of_a_kind: %w(TS TC TH 5D TD),
      full_house: %w(TS TC TH 5D 5C),
      flush: %w(AS TS 9S 3S 2S),
      ace_high_straight: %w(AS TD JC QH KC),
      straight: %w(9S TS 8D 7S JS),
      ace_low_straight: %w(AS 2H 3D 5C 4S),
      three_of_a_kind: %w(3C 3S AD 3H 2D),
      two_pair: %w(AC AS 3H 3D 2D),
      pair: %w(KC KD 3H JD TS),
      high_card: %w(KC QD TC 4D 5S)
    }
    return available_hands[hand_type]
  end
  # all the tests for the hand

  describe "#hand_type" do
    it "should return 'straight_flush' for hand_type" do
      hand = Hand.new(cards(:straight_flush))

      expect(hand.hand_type).to eq("straight_flush")
    end

    it "should return 'high_card' when nothing matches" do
      hand = Hand.new(cards(:high_card))

      expect(hand.hand_type).to eq("high_card")
    end
  end

  describe "#hand_score" do
    it "should return a score for all hand types" do
      straight_flush = Hand.new(cards(:straight_flush))
      four_of_a_kind = Hand.new(cards(:four_of_a_kind))
      full_house = Hand.new(cards(:full_house))
      flush = Hand.new(cards(:flush))
      straight = Hand.new(cards(:straight))
      three_of_a_kind = Hand.new(cards(:three_of_a_kind))
      two_pair = Hand.new(cards(:two_pair))
      pair = Hand.new(cards(:pair))
      
      expect(straight_flush.hand_score).to eq(8)
      expect(four_of_a_kind.hand_score).to eq(7)
      expect(full_house.hand_score).to eq(6)
      expect(flush.hand_score).to eq(5)
      expect(straight.hand_score).to eq(4)
      expect(three_of_a_kind.hand_score).to eq(3)
      expect(two_pair.hand_score).to eq(2)
      expect(pair.hand_score).to eq(1)
    end
  end

  describe "#card_scores" do
    it "returns the individual score of each card in the hand" do
      hand = Hand.new(["AH", "QC"])

      expect(hand.card_scores).to eq([14, 12])
    end
  end

  describe "#base_score" do
    it "should return the card score of the paired card" do
      pair = Hand.new(cards(:pair))

      expect(pair.base_score).to eq(13)
    end

    it "should return the card score of the paird card even if it is lower than the kicker" do
      pair = Hand.new(["AH", "2D", "2C", "3C", "4D"])

      expect(pair.base_score).to eq(2)
    end

    it "returns highest pair, even if the higher pair comes later" do
      two_pair = Hand.new(["2H", "2D", "AD", "AH", "QC"])

      expect(two_pair.base_score).to eq(14)
    end

    it "returns the highest pair of the two pair" do
      two_pair = Hand.new(["AD", "AH", "2D", "2D", "QC"])

      expect(two_pair.base_score).to eq(14)
    end
  end


  describe "#hand_scores" do
    it "should return [] with the hand_score inside" do
      straight_flush = Hand.new(cards(:straight_flush))

      expect(straight_flush.hand_scores).to eq([8, 11])
    end

    it "expect it to recognize a straight with a low ace as a kicker with a 5" do
      straight = Hand.new(cards(:ace_low_straight))

      expect(straight.hand_scores).to eq([4, 5])
    end

    it "returns the value of the most paired card for full_house" do
      full_house = Hand.new(cards(:full_house))

      expect(full_house.hand_scores).to eq([6, 10])
    end
    it "returns card score of the four_of_a_kind" do
      four_of_a_kind = Hand.new(cards(:four_of_a_kind))
      
      expect(four_of_a_kind.hand_scores).to eq([7, 10])
    end
    
    it "returns card score of the four_of_a_kind" do
      three_of_a_kind = Hand.new(cards(:three_of_a_kind))
      
      expect(three_of_a_kind.hand_scores).to eq([3, 3])
    end

    it "returns value of highest card in high card" do
      high_card = Hand.new(cards(:high_card))

      expect(high_card.hand_scores).to eq([0, 13])
    end

    it "returns value of highest card in flush" do
      flush = Hand.new(cards(:flush))

      expect(flush.hand_scores).to eq([5, 14])
    end
  end
  describe "#most_highly_paired_card_score" do
    it "should return the card score of the most highly paired card in hand" do
      full_house = Hand.new(cards(:full_house))

      expect(full_house.most_highly_paired_card_score).to eq(10)
    end
  end

  describe "#individual_card_score" do
    it "should give the score of a card when you give it the card" do
      hand = Hand.new("")

      expect(hand.individual_card_score(card:"T")).to eq(10)
    end
  end

  describe "#straight_flush?" do
    it "recognizes Straight Flushes!" do
      hand = Hand.new(cards(:straight_flush))

      expect(hand.straight_flush?).to eq(true)
    end
  end

  describe "#four_of_a_kind?" do
    it "returns true for a hand with a 4 of a kind" do
      hand = Hand.new(cards(:four_of_a_kind))

      expect(hand.four_of_a_kind?).to eq(true)
    end

    it "returns false for 3 of a kind" do
      hand = Hand.new(cards(:three_of_a_kind))

      expect(hand.four_of_a_kind?).to eq(false)
    end
  end

  describe "#full_house?" do
    it "returns true when a full house exists" do
      hand = Hand.new(cards(:full_house))

      expect(hand.full_house?).to eq(true)
    end

    it "returns false when two pair" do
      hand = Hand.new(cards(:two_pair))

      expect(hand.full_house?).to eq(false)
    end
  end

  describe "#flush?" do
    it "returns true when hand is flush" do
      hand = Hand.new(cards(:flush))
      
      expect(hand.flush?).to eq(true)
    end
    it "returns false when it is not a flush" do
      hand = Hand.new(cards(:straight))
      
      expect(hand.flush?).to eq(false)
    end
  end

  describe "#straight?" do
    it "returns false on non straights" do
      hand = Hand.new(cards(:flush))
      
      expect(hand.straight?).to eq(false)
    end

    it "recognizes normal straights to be true" do
      hand = Hand.new(cards(:straight))

      expect(hand.straight?).to eq(true)
    end

    it "recognizes low straights starting with an Ace" do
      hand = Hand.new(cards(:ace_low_straight))

      expect(hand.straight?).to eq(true)
    end

    it "recognizes high straights ending with Ace" do
      hand = Hand.new(cards(:ace_high_straight))

      expect(hand.straight?).to eq(true)
    end
  end

  describe "#three_of_a_kind?" do
    it "returns true for a hand with a 3 of a kind" do
      hand = Hand.new(cards(:three_of_a_kind))

      expect(hand.three_of_a_kind?).to eq(true)
    end

    it "returns false for 4 of a kind" do
      hand = Hand.new(cards(:four_of_a_kind))

      expect(hand.three_of_a_kind?).to eq(false)
    end
  end

  describe "#two_pair?" do
    it "returns false for full house" do
      hand = Hand.new(cards(:full_house))

      expect(hand.two_pair?).to eq(false)
    end

    it "returns true for two pair" do
      hand = Hand.new(cards(:two_pair))

      expect(hand.two_pair?).to eq(true)
    end

    it "returns false for 4 of a kind" do
      hand = Hand.new(cards(:four_of_a_kind))

      expect(hand.two_pair?).to eq(false)
    end
  end

  describe "#number_of_pairs" do
    it "returns the 1 for a four of a kind" do
      hand = Hand.new(cards(:four_of_a_kind))
      
      expect(hand.number_of_pairs).to eq(1)
    end

    it "returns 2 for full house" do
      hand = Hand.new(cards(:full_house))

      expect(hand.number_of_pairs).to eq(2)
    end

    it "returns 2 for two pair" do
      hand = Hand.new(cards(:two_pair))

      expect(hand.number_of_pairs).to eq(2)
    end
  end

  describe "#occurances_in_pair" do
    it "returns 4 for four of a kind" do
      hand = Hand.new(cards(:four_of_a_kind))

      expect(hand.occurances_in_pair).to eq(4)
    end

    it "returns 3 for full house" do
      hand = Hand.new(cards(:full_house))

      expect(hand.occurances_in_pair).to eq(3)
    end

    it "returns 2 for two pair" do
      hand = Hand.new(cards(:two_pair))

      expect(hand.occurances_in_pair).to eq(2)
    end
  end


  describe "#valid_hand?" do
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

  describe "#card_values_ranked(ace_value: 14)" do
    it "sorts the card_values and ranks them from 1-14" do
      # I wrote in a hand, rather than grabbing a method from above because I thought it was important to see the values all on one screen
      hand = Hand.new(["AS", "TD", "QH", "KH", "9H"])

      expect(hand.card_values_ranked).to eq([14, 10, 12, 13, 9])
    end
  end

  describe "#card_rankings_sorted(ace_value: 14)" do
    it "returns a sorted array of card rankings" do
      hand = Hand.new(["AS", "TD", "QH", "KH", "9H"])
      
      expect(hand.card_rankings_sorted).to eq([9, 10, 12, 13, 14])
    end

    it "returns a value of 1 for for aces, when specified" do
      hand = Hand.new(["AS", "TD", "QH", "KH", "9H"])

      expect(hand.card_rankings_sorted(ace_value: 1)).to eq([1, 9, 10, 12, 13])
    end
  end


  describe "#straight_generator" do
    it "should create a 5 card array in order" do
      initial_card_rank = 4
      
      expect(Hand.new("").straight_generator(initial_card_rank)).to eq([4, 5, 6, 7, 8])
    end
  end
end
