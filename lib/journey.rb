require 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_reader :list_of_journeys, :valid

  def initialize
    @list_of_journeys = []
    @valid = true
  end


  def start_journey(entry_station)
    @entry_station = entry_station
    @valid = false
  end

  def end_journey(exit_station)
    @exit_station = exit_station
    @valid = true if @valid = false
    store_journey
  end

  def fare
    if @valid == false
      "Penalty of £#{Journey::PENALTY_FARE} issued"
    else
      Oystercard::MINIMUM_FARE
    end
  end

  private

  def store_journey
    @list_of_journeys << {:entry_station => @entry_station, :exit_station => @exit_station}
  end

end
