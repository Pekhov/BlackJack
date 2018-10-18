require_relative('deck')
require_relative('card')

class Player
  attr_reader :name
  attr_accessor :bank, :cards

  def initialize(name)
    @name = name
    @bank = 0
  end

  def take_card(cards)
    if @cards
      self.cards += cards
    else
      self.cards = cards
    end
  end

  def return_cards
    self.cards = nil
  end

  def player_cards
    (cards.map { |card| "#{card.value}#{card.suit}" }).join(' ')
  end

  def card_sum
    values = assign_values
    values.each do |value|
      if values.sum < 21 && value == 1
        values[values.index(value)] = 11 if values.sum + 10 < 22
      end
    end
    values.sum
  end

  def assign_values
    values = []
    cards.each do |card|
      values << if pictures.include?(card.value)
                  10
                elsif card.value == 'Т'
                  1
                else
                  card.value
                end
    end
    values
  end

  def two_cards?
    self.cards.size == 2
  end

  def pictures
    %w[В Д К]
  end
end
