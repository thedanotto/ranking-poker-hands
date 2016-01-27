class HandEvaluator
  require_relative 'hand'

  attr_accessor :hand1, :hand2

  def initialize(hand1, hand2)
    # hands will be coming in as hand objects...
    @hand1 = hand1
    @hand2 = hand2

  end

  def return_stronger_hand(hand1: self.hand1, hand2: self.hand2)
    if hand1.hand_scores[0] > hand2.hand_scores[0]
      return hand1
    elsif hand2.hand_scores[0] > hand1.hand_scores[0]
      return hand2
    elsif hand1.hand_scores[1] > hand2.hand_scores[1]
      return hand1
    elsif hand2.hand_scores[1] > hand1.hand_scores[1]
      return hand2
    else
      # haven't figured out the kickers quite yet...
      return hand1
    end
  end
end
