class Cards

  attr_accessor :suit, :value

  SUIT = %w[♣ ♥ ♦ ♠].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'В', 'Д', 'К', 'Т']

  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end
