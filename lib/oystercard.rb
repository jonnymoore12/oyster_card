class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_CREDIT = 1


attr_reader :balance, :list_of_journeys, :entrance_station, :exit_station

  def initialize
    @balance = 0
    @list_of_journeys = {}
    @entrance_station
    @exit_station
  end

  def top_up(amount)
   fail "Maximum balance of #{MAXIMUM_BALANCE} reached" if balance + amount > MAXIMUM_BALANCE
   @balance += amount
  end

  def touch_in(current_station)
    raise "No credit on card" if no_credit
    @list_of_journeys[:entrance_station] = current_station
    @entrance_station = current_station
    @exit_station = nil
  end


  def touch_out(exit_station)
     deduct(MINIMUM_CREDIT)
     @list_of_journeys[:exit_station] = exit_station
     @exit_station = exit_station
     @entrance_station = nil
  end

  def in_journey?
     !!@entrance_station
  end

  def no_credit
    @balance < MINIMUM_CREDIT
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
