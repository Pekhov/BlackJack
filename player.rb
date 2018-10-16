require_relative('deck')
require_relative('cards')

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
    values = []
    @cards.each do |card|
      values << if pictures.include?(card.value)
                  10
                elsif card.value == 'Т' && values.sum > 10
                  1
                elsif card.value == 'Т' && values.sum <= 10
                  11
                else
                  card.value
                end
    end
    values.sum
  end

  def pictures
    %w[В Д К]
  end

end
