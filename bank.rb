class Bank
  attr_accessor :amount

  class << self
    attr_accessor :bank
  end

  @bank = 0

  def initialize(player)
    @amount = 100
    @player = player
  end

  def place_bet
    self.class.bank += 10
    self.amount -= 10
  end

  def money_to_winner
    self.amount += self.class.bank
    self.class.bank = 0
  end

  def return_money
    self.amount += 10
    self.class.bank = 0
  end

end
