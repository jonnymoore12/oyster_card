class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_CREDIT = 1


attr_reader :balance
attr_reader :entry_station

  def initialize
    @balance = 0
    @entry_station
  end

  def top_up(amount)
   fail "Maximum balance of #{MAXIMUM_BALANCE} reached" if balance + amount > MAXIMUM_BALANCE
   @balance += amount
  end

  def touch_in(current_station)
    raise "No credit on card" if no_credit
    @entry_station = current_station
  end


  def touch_out
     deduct(MINIMUM_CREDIT)
     @entry_station = nil
  end

  def in_journey?
     !!@entry_station
  end

  def no_credit
    @balance < MINIMUM_CREDIT
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
