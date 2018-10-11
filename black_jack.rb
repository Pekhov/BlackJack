require_relative 'user'
require_relative 'dealer'
require_relative 'bank'

class BlackJack
  def initialize
    @user = join_player
    @dealer = Dealer.new("Dealer")
    @user_bank = Bank.new(@user)
    @dealer_bank = Bank.new(@dealer)
    start_game
  end

  protected

  def join_player
    print "Добро пожаловать в игру BlackJack!\nВведите ваше имя: "
    user_name = gets.chomp.to_s
    User.new(user_name)
  end

  def start_game; end
end

BlackJack.new
