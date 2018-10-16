require_relative 'player'
require_relative 'deck'

class Dealer < Player

  def dealer_move(game)
    self.take_card(game.deck.get_card) if self.card_sum < 17 && self.cards.size == 2
    game.check_cards_count ? game.open_cards : game.user_move
  end
end
