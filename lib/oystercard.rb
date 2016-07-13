class Oystercard

  LIMIT = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  attr_accessor :balance, :entry_station, :exit_station, :journey_history, :journey

  def initialize
    @balance = 0
    #@in_journey = false
    @entry_station = nil
    @journey_history = []
    @journey = {}
  end

  def journey(station1, station2)
    @journey = {entry_station: station1, exit_station: station2}
  end

  def top_up(amount)
    error = "Top up would exceed card limit of £#{LIMIT}"
    fail error if (amount + @balance) > LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance" unless @balance >= MIN_BALANCE
    @entry_station = station
    @exit_station = nil
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @exit_station = station
    journey(@entry_station, @exit_station)
    @journey_history << @journey
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
