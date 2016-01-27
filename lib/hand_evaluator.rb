class HandEvaluator
  include Comparable
  require_relative 'hand'
  # I want to put all evaluation of the hand in HandEvalutor, it is only 

  attr_accessor :hand1, :hand2

  def initialize(hand1, hand2)
    # hands will be coming in as hand objects...
    @hand1 = hand1
    @hand2 = hand2

  end

  def compare_hands
    hand1.hand_scores <=> hand2.hand_scores
  end

  def return_stronger_hand
    if compare_hands == 1 
      return hand1
    else
      return hand2
    end
  end
end
