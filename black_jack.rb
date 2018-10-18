require_relative 'bank'
require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'interface'

class BlackJack

  attr_reader :deck

  def initialize
    @ui = Interface.new
    @user = Player.new(@ui.get_user_name)
    @dealer = Dealer.new("Dealer")
    @user.bank = Bank.new(@user)
    @dealer.bank = Bank.new(@dealer)
    @ui.welcome_message
    new_game_initialize
  end

  def new_game_initialize
    loop do
      @deck = Deck.new
      if @user.cards
        @user.return_cards
        @dealer.return_cards
      end
      @user.take_card(@deck.get_start_cards)
      @dealer.take_card(@deck.get_start_cards)
      return unless start_game
    end
  end

  def start_game
    start_bet
    user_move
    try_again?
  end

  def start_bet
    @user.bank.place_bet
    @dealer.bank.place_bet
    @ui.bet_message(@user.bank.amount, @dealer.bank.amount)
  end

  def user_move
    answer = @ui.user_move_menu(@user.player_cards, @user.card_sum, @dealer.hide_cards, @user.two_cards?)
    case answer
    when 1
      open_cards
    when 2
      dealer_move
    when 3
      if @user.two_cards?
        @user.take_card(@deck.get_card)
        dealer_move
      else
        exit
      end
    end
  end

  def dealer_move
    @dealer.take_card(@deck.get_card) if @dealer.take_card?
    next_move?
  end

  def next_move?
    check_cards_count ? open_cards : user_move
  end

  def check_cards_count
    @dealer.cards.size == 3 && @user.cards.size == 3
  end

  def open_cards
    @ui.show_cards(@user.player_cards, @user.card_sum, @dealer.player_cards, @dealer.card_sum)
    @ui.show_game_result(winner, @user.name, @dealer.name)
    case winner
    when :draw
      return_money(@user, @dealer)
    when :user
      @user.bank.money_to_winner
    when :dealer
      @dealer.bank.money_to_winner
    end
    check_pleer_bank
  end

  def winner
    user_card_sum = @user.card_sum
    dealer_card_sum = @dealer.card_sum
    if user_card_sum > 21 && dealer_card_sum > 21
      return :nobody
    elsif user_card_sum == dealer_card_sum
      return :draw
    elsif user_card_sum < 22 && dealer_card_sum > 21
      return :user
    elsif dealer_card_sum < 22 && user_card_sum > 21
      return :dealer
    elsif dealer_card_sum > user_card_sum
      return :dealer
    elsif dealer_card_sum < user_card_sum
      return :user
    end
  end

  def return_money(*players)
    players.each { |player| player.bank.return_money }
  end

  def try_again?
    answer = @ui.try_again_menu
    answer == 1
  end

  def check_pleer_bank
    if @user.bank.amount < 10
      @ui.dealer_win(@user.bank.amount)
      exit
    elsif @dealer.bank.amount < 10
      @ui.user_win(@dealer.bank.amount)
      exit
    end
  end


end

BlackJack.new
