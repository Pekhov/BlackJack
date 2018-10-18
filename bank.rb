class Bank
  attr_accessor :amount

  class << self
    attr_accessor :bank
  end

  @bank = 0
  START_AMOUNT = 100
  SINGLE_BET = 10

  def initialize(player)
    @amount = START_AMOUNT
    @player = player
  end

  def place_bet
    self.class.bank += SINGLE_BET
    self.amount -= SINGLE_BET
  end

  def money_to_winner
    self.amount += self.class.bank
    self.class.bank = 0
  end

  def return_money
    self.amount += SINGLE_BET
    self.class.bank = 0
  end
end
