class Deck

  suit = ['♣', '♥', '♦', '♠']
  values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'В', 'Д', 'К', 'Т']
  @deck_of_cards = {}
  suit.each do |suit|
    values.each do |value|
      @deck_of_cards["#{value}#{suit}"] = 10
      @deck_of_cards["#{value}#{suit}"] = value if value.is_a?(Integer)
    end
  end

  class << self
    attr_reader :deck_of_cards

    def random_card(count)
      @deck_of_cards.keys.sample(count)
    end
  end

end

