require_relative 'user'
require_relative 'dealer'
require_relative 'bank'
require_relative 'deck'
require_relative 'interface'

class BlackJack

  def initialize
    @ui = Interface.new
    @user = Player.new(@ui.get_user_name)
    @dealer = Player.new("Dealer")
    @user.bank = Bank.new(@user)
    @dealer.bank = Bank.new(@dealer)
    @ui.welcome_message
    new_game_initialize
  end

  protected

  def new_game_initialize
    @user.cards = first_cards
    @dealer.cards = first_cards
    start_game
  end

  def first_cards
    Deck.random_card(2)
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
    @ui.user_move_menu(@user.cards.join(' '), @user.card_sum, @dealer.cards.map { |card| '*' }.join(' '), @user.cards.size == 2 ? true : false)
    case gets.chomp.to_i
    when 1
      open_cards
    when 2
      dealer_move
    when 3
      add_card(@user)
      dealer_move
    end
  end

  def add_card(user)
    user.cards << Deck.random_card(1).join
  end

  def dealer_move
    add_card(@dealer) if @dealer.card_sum < 17 && @dealer.cards.size == 2
    check_cards_count ? open_cards : user_move
  end

  def check_cards_count
    @dealer.cards.size == 3 && @user.cards.size == 3
  end

  def open_cards
    @ui.show_cards(@user.cards.join(' '), @user.card_sum, @dealer.cards.join(' '), @dealer.card_sum)
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
    if answer == 1
      new_game_initialize
    else
      exit
    end
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
