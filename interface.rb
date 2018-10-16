class Interface

  def welcome_message
    puts "Добро пожаловать в игру BlackJack!\n"
  end

  def get_user_name
    print "Введите ваше имя: "
    gets.chomp.to_s
  end

  def bet_message(user_amount, dealer_amount)
    puts "Сделали ставки в 10$. На вашем счету #{user_amount}$. У дилера: #{dealer_amount}$"
  end

  def user_move_menu(user_cards, user_cards_sum, dealer_cards, add_card)
    puts "\nУ вас на руках карты: #{user_cards}, с суммой очков #{user_cards_sum}"
    puts "У дилера на руках карты: #{dealer_cards}"
    puts "Введите 1, что бы открыть карты"
    puts "Введите 2, что бы пропустить ход"
    puts "Введите 3, что бы добавить карту" if add_card
    gets.chomp.to_i
  end

  def show_cards(user_cards, user_sum, dealer_cards, dealer_sum)
    puts "\nУ вас на руках карты: #{user_cards}, с суммой очков #{user_sum}"
    puts "У дилера на руках карты: #{dealer_cards}, с суммой очков #{dealer_sum}\n"
  end

  def show_game_result(winner, user_name, dealer_name)
    case winner
    when :nobody
      puts "Оба игрока набрали больше 21 очка. Ставка в 10$ не возвращается."
    when :draw
      puts "Ничья"
    when :user
      puts "Победил #{user_name}"
    when :dealer
      puts "Победил #{dealer_name}"
    end
  end

  def try_again_menu
    puts "\nВведите 1, что бы сыграть заново\nВведите 2 для выхода"
    gets.chomp.to_i
  end

  def dealer_win(user_amount)
    puts "На вашем счете #{user_amount}$. Этого недостаточно для игры, прощайте;)"
  end

  def user_win(dealer_amount)
    puts "У дилера на счете #{dealer_amount}$. Поздравляем, вы выйграли!"
  end

end
