require_relative 'cards'

class Deck
  attr_reader :deck

  def initialize
    @deck = create_deck
  end

  def create_deck
    deck = []
    suit = Cards::SUIT
    values = Cards::VALUES
    suit.each do |suit|
      values.each do |value|
        deck << Cards.new(value, suit)
      end
    end
    return deck.shuffle
  end

  def get_card(number = 1)
    cards = @deck.first(number)
    @deck -= cards
    return cards
  end

  def get_start_cards
    get_card(2)
  end

end

