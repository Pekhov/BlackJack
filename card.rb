class Card

  attr_reader :suit, :value

  SUIT = %w[♣ ♥ ♦ ♠].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'В', 'Д', 'К', 'Т'].freeze

  def initialize(value, suit)
    @value = value
    @suit = suit
    validate_card
  end

  def validate_card
    raise "No valid value" unless VALUES.include?(@value)
    raise "No valid suit" unless SUIT.include?(@suit)
  end
end
