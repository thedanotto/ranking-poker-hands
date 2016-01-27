class Hand
  attr_accessor :cards, :suits, :values, :card_scores
  
  def initialize(cards)
    @cards = cards
  end

  # Utility Methods
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
 
  def card_values
    values = []
    self.cards.each do |card|
      values << card[0]
    end
    return values
  end

  def card_scores
    card_scores = []
    self.card_values.each do |card|
      card_scores << individual_card_score(card: card)
    end
    return card_scores
  end

  def suits
    suits = []
    self.cards.each do |card|
      suits << card[1]
    end
    return suits
  end

  # determine Hand Type
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
    score_array << self.kickers if self.kickers
    score_array = score_array + self.kickers2 if self.kickers2
    
    score_array
  end

  def base_score
    if two_pair?
      self.card_score_of_strongest_pair
    elsif number_of_pairs > 0
      self.most_highly_paired_card_score
    elsif aces_low_straight?
      self.card_rankings_sorted(ace_value: 1).max
    else
      self.card_rankings_sorted.max
    end
  end

  def sort_card_scores
    self.card_scores.group_by {|x| x}.values.sort_by(&:max).reverse.flat_map {|i| i}
  end

  def card_score_of_strongest_pair
    sorted_card_scores = sort_card_scores
    paired_card_scores = remove_uniques(sorted_card_scores) 
    paired_card_scores[0]
  end

  def card_score_of_second_strongest_pair
    sorted_card_scores = sort_card_scores
    paired_card_scores = remove_uniques(sorted_card_scores) 
    paired_card_scores[1]
  end

  def card_score_of_all_free_cards
    sorted_card_scores = sort_card_scores
    solo_card_scores = grab_solo_cards(sorted_card_scores) 
    
    solo_card_scores
  end

  def grab_solo_cards(arr)
    # removes unique  values from an array
    arr.uniq.select do |uniq_value|
      arr.count(uniq_value) == 1
    end  
  end  

  def kickers
    if two_pair?
      self.card_score_of_second_strongest_pair
    elsif full_house?
      self.card_score_of_second_pair
    end
  end

  def card_score_of_second_pair
    self.card_scores.group_by{|x| x}.values.sort_by(&:length).flat_map {|i| i}[0]
  end

  def kickers2
    # this method should really repeat, and grab all the free cards and put them in the base score, but whatever, we'll add that test later...
    if two_pair? or pair? or high_card?
      self.card_score_of_all_free_cards
    end
  end

  def remove_uniques(arr)
    # removes unique  values from an array
    arr.uniq.select do |uniq_value|
      arr.count(uniq_value) > 1
    end  
  end  

  def straight_flush?
    self.flush? && self.straight?
  end 

  def four_of_a_kind?
    number_of_pairs == 1 && occurences_in_pair == 4
  end 

  def full_house?
    number_of_pairs == 2 && occurences_in_pair == 3
  end 

  def flush?
    self.suits.uniq.one?
  end 

  def straight?
    aces_low_straight? || aces_high_straight?
  end 
  
  def three_of_a_kind?
    number_of_pairs == 1 && occurences_in_pair == 3
  end 

  def two_pair?
    number_of_pairs == 2 && occurences_in_pair == 2
  end 

  def pair?
    number_of_pairs == 1 && occurences_in_pair == 2
  end 

  def high_card?
    number_of_pairs == 0 && !flush? && !straight?
  end 

  def card_occurences
    self.card_values.each_with_object(Hash.new(0)) { |card, counts| counts[card] += 1 }
  end

  def number_of_pairs
    instances_of_pairs = self.card_occurences.to_a.select do |arr|
      arr[1] > 1
    end
    instances_of_pairs.count
  end

  def occurences_in_pair
    instances = []
    self.card_occurences.each do |arr|
      instances << arr[1]
    end
    instances.max
  end


  def most_highly_paired_card_score
    # grabs the ["card_value", "occurences"]
    max = self.card_occurences.max_by do |k, v|
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
