class Hand
  attr_accessor :cards
  
  def initialize(cards)
    @cards = cards
  end

  def card_values
    values = []
    self.cards.each do |card|
      values << card[0]
    end
    return values
  end

  def hand_type
    
  end

  def suits
    suits = []
    self.cards.each do |card|
      suits << card[1]
    end
    return suits
  end
  
  def valid_hand?
    self.cards.length == 5
  end

  def straight_flush?
    self.flush? && self.straight?
  end 

  def four_of_a_kind?
    number_of_pairs == 1 && occurances_in_pair == 4
  end 

  def full_house?
    number_of_pairs == 2 && occurances_in_pair == 3
  end 

  def flush?
    self.suits.uniq.one?
  end 

  def straight?
    aces_low_straight? || aces_high_straight?
  end 
  
  def three_of_a_kind?
    number_of_pairs == 1 && occurances_in_pair == 3
  end 

  def two_pair?
    number_of_pairs == 2 && occurances_in_pair == 2
  end 

  def pair?
    number_of_pairs == 1 && occurances_in_pair == 2
  end 

  def high_card?
    true 
  end 

  def number_of_pairs
    card_occurences = self.card_values.each_with_object(Hash.new(0)) { |card, counts| counts[card] += 1 }
    instances_of_pairs = card_occurences.to_a.select do |arr|
      arr[1] > 1
    end
    instances_of_pairs.count
  end

  def occurances_in_pair
    instances = []
    card_occurances = self.card_values.each_with_object(Hash.new(0)) { |card, counts| counts[card] += 1 }
    card_occurances.each do |arr|
      instances << arr[1]
    end
    instances.max
  end

  def aces_low_straight?
    your_card_rankings = self.card_rankings_sorted(ace_value: 1)
    self.straight_generator(your_card_rankings[0]) == your_card_rankings
  end

  def aces_high_straight?
    your_card_rankings = self.card_rankings_sorted
    self.straight_generator(your_card_rankings[0]) == your_card_rankings
  end

  def straight_generator(lowest_card_value)
    straight_tester = [lowest_card_value]
    4.times do |num|
      straight_tester << lowest_card_value + num + 1
    end
    straight_tester
  end

  def card_values_ranked(ace_value: 14)
    card_rankings = {
      "A" =>  ace_value,
      "K" => 13,
      "Q" =>  12,
      "J" =>  11,
      "T" =>  10,
      "9" =>  9,
      "8" => 8,
      "7" => 7,
      "6" => 6,
      "5" => 5,
      "4" => 4,
      "3" => 3,
      "2" => 2
    }
    @card_values ||= self.card_values
    card_ranks = []
    @card_values.each do |card|
      card_ranks << card_rankings[card]
    end
    card_ranks
  end

  def card_rankings_sorted(ace_value: 14)
    your_card_rankings = self.card_values_ranked(ace_value: ace_value)
    your_card_rankings.sort
  end
end
