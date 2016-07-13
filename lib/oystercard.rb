require_relative 'station'

class Oystercard

  LIMIT = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  attr_accessor :balance, :entry_station, :exit_station, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    fail "Top up limit £#{LIMIT} would be exceeded" if (amount + @balance) > LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance" unless @balance >= MIN_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @exit_station = station
    log_journey
    clear_stations
  end

  def in_journey?
    !!@entry_station
  end

private

  def deduct(amount)
    @balance -= amount
  end

  def log_journey
    journey = {entry_station: entry_station, exit_station: exit_station}
    @journey_history << journey
  end

  def clear_stations
    @entry_station, @exit_station = nil
  end

end
