require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_reader :list_of_journeys, :entry_station, :exit_station

  def initialize
    @list_of_journeys = []
    @entry_station
    @exit_station
  end

  def start_journey(entry_station = nil)
    @entry_station = entry_station
    greeting_message
  end

  def end_journey(exit_station = nil)
    @exit_station = exit_station
    greeting_message
    store_journey
  end

  def fare
    return Journey::PENALTY_FARE if (@entry_station == nil) || (@exit_station == nil)
    Oystercard::MINIMUM_FARE
  end

  private

  def store_journey
    @list_of_journeys << {:entry_station => @entry_station, :exit_station => @exit_station}
  end

  def greeting_message
    if (@entry_station == nil) || (@exit_station == nil)
      p "You ballsed up your journey to the tune of #{PENALTY_FARE}"
    else
      p "Welcome, have a nice day!"
    end
  end

end
