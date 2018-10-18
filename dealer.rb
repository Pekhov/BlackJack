require_relative 'player'

class Dealer < Player
  def take_card?
    card_sum < 17 && cards.size == 2
  end

  def hide_cards
    cards.map { '*' }.join(' ')
  end
end
