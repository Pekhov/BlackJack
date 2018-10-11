require_relative 'user'
require_relative 'dealer'
require_relative 'bank'
require_relative 'deck'

class BlackJack

  def initialize
    @user = User.new(user_name)
    @dealer = Dealer.new("Dealer")
    @user.bank = Bank.new(@user)
    @dealer.bank = Bank.new(@dealer)
    @user.cards = first_cards
    @dealer.cards = first_cards
    start_game
  end

  protected

  def user_name
    print "Введите ваше имя: "
    gets.chomp.to_s
  end

  def first_cards
    Deck.random_card(2)
  end

  def start_game
    puts "Добро пожаловать в игру BlackJack!"

  end

end

BlackJack.new
