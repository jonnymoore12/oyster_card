class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
  end
  require 'pry'; binding .pry
  def top_up amount
    @balance += amount
  end

end
