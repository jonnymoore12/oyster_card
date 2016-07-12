class Oystercard

  attr_reader :balance, :min_fare

  LIMIT = 150
  MINFARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @min_fare = MINFARE
  end

  def top_up amount
    fail "limit #{LIMIT} reached" if @balance + amount > LIMIT
    @balance += amount
  end

  def deduct amount
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "balance too low" if @balance < @min_fare
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
