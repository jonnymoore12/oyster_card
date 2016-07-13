class Oystercard

  LIMIT = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  attr_accessor :balance, :entry_station

  def initialize
    @balance = 0
    #@in_journey = false
    @entry_station = nil
  end

  def top_up(amount)
    error = "Top up would exceed card limit of £#{LIMIT}"
    fail error if (amount + @balance) > LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance" unless @balance >= MIN_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
