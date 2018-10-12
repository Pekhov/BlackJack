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
    new_game_initialize
  end

  protected

  def new_game_initialize
    puts "Добро пожаловать в игру BlackJack!\n"
    @user.cards = first_cards
    @dealer.cards = first_cards
    start_game
  end

  def user_name
    print "Введите ваше имя: "
    gets.chomp.to_s
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
    puts "Сделали ставки в 10$. На вашем счету #{@user.bank.amount}$. У дилера: #{@dealer.bank.amount}$"
  end

  def user_move
    puts "\nУ вас на руках карты: #{@user.cards.join(' ')}, с суммой очков #{@user.card_sum}"
    puts "У дилера на руках карты: #{@dealer.cards.map { |card| '*' }.join(' ')}"
    puts "Введите 1, что бы открыть карты"
    puts "Введите 2, что бы пропустить ход"
    puts "Введите 3, что бы добавить карту" if @user.cards.size == 2
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
    user.cards << Deck.random_card(1).join.to_sym
  end

  def dealer_move
    add_card(@dealer) if @dealer.card_sum < 17 && @dealer.cards.size == 2
    check_cards_count ? open_cards : user_move
  end

  def check_cards_count
    @dealer.cards.size == 3 && @user.cards.size == 3
  end

  def open_cards
    puts "\nУ вас на руках карты: #{@user.cards.join(' ')}, с суммой очков #{@user.card_sum}"
    puts "У дилера на руках карты: #{@dealer.cards.join(' ')}, с суммой очков #{@dealer.card_sum}\n"
    case winner
    when :nobody
      puts "Оба игрока набрали больше 21 очка"
    when :draw
      puts "Ничья"
      return_money(@user, @dealer)
    when :user
      puts "Победил #{@user.name}"
      @user.bank.money_to_winner
    when :dealer
      puts "Победил #{@dealer.name}"
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
    puts "\nВведите 1, что бы сыграть заново\nВведите 2 для выхода"
    if gets.chomp.to_i == 1
      new_game_initialize
    else
      exit
    end
  end

  def check_pleer_bank
    if @user.bank.amount < 10
      puts "На вашем счете #{@user.bank.amount}$. Этого недостаточно для игры, прощайте;)"
      exit
    elsif @dealer.bank.amount < 10
      puts "У дилера на счете #{@dealer.bank.amount}$. Поздравляем, вы выйграли!"
      exit
    end
  end


end

BlackJack.new
