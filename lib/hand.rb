class Hand
  attr_accessor :cards
    def individual_card_score(card:, ace_value: 14)
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
    card_rankings[card]
    end
 
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
    if straight_flush?
      "straight_flush"
    elsif four_of_a_kind?
      "four_of_a_kind"
    elsif full_house?
      "full_house"
    elsif flush?
      "flush"
    elsif straight?
      "straight"
    elsif three_of_a_kind?
      "three_of_a_kind"
    elsif two_pair?
      "two_pair"
    elsif pair?
      "pair"
    else
      "high_card"
    end
  end

  def hand_score(hand_type: self.hand_type)
    scores = {
      "straight_flush" =>  8,
      "four_of_a_kind" =>  7,
      "full_house" =>  6,
      "flush" =>  5,
      "straight" =>  4,
      "three_of_a_kind" => 3,
      "two_pair" => 2,
      "pair" => 1,
      "high_card" => 0
    }

    scores[hand_type]
  end

  def hand_scores
    score_array = []
    score_array << hand_score
    score_array << self.base_score
    #score_array << self.kicker
  end

  def base_score
    if number_of_pairs > 0
      self.most_highly_paired_card_score
    elsif aces_low_straight?
      self.card_rankings_sorted(ace_value: 1).max
    else
      self.card_rankings_sorted.max
    end
  end

  # there has to be a way to write a method that just does all the kickers for everything...
  def kicker
  end


  # straights, flushes, high card all take the highest card as their second score (done)
  # foak, toak, tp, p, full_house all take their most paired card as their second score
  # kicker 1 foak, toak, p all take their next highest card
  # kicker 1 full_house, two_pair, all take their second pair as the kicker
  # kicker 2 two_pair takes its remaining card, toak take its remaining card, pair takes its second highest card
  # kicker 3 pair takes its last card as final determination

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

  def most_highly_paired_card_score
    card_occurances = self.card_values.each_with_object(Hash.new(0)) { |card, counts| counts[card] += 1 }
    # grabs the ["card_value", "occurances"]
    max = card_occurances.max_by do |k, v|
      v
    end
    self.individual_card_score(card: max[0])
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
