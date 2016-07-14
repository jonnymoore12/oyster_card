require_relative 'journey'

class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_CREDIT = 1
MINIMUM_FARE = 1


attr_reader :balance, :journey

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} reached" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
   end

  def touch_in(current_station)
    fail "No credit on card" if no_credit
    @journey.start_journey(current_station)
    deduct(journey.fare)
  end

  def touch_out(exit_station)
    @journey.end_journey(exit_station)
    deduct(journey.fare)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def no_credit
    @balance < MINIMUM_CREDIT
  end

end
