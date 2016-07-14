require 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_reader :list_of_journeys

  def initialize
    @list_of_journeys = []
    @entry_station = 'New Card'
    @exit_station = 'New Card'
  end


  def start_journey(entry_station)
    no_touch if @entry_station
    @entry_station = entry_station
    @exit_station = nil
    @no_touch = false
  end

  def end_journey(exit_station)
    no_touch if @exit_station
    @exit_station = exit_station
    store_journey
    @entry_station = nil
    @no_touch = false
  end

  def fare
    if no_touch
      "Penalty of £#{Journey::PENALTY_FARE} issued"
    else
      Oystercard::MINIMUM_FARE
    end
  end

  private

  def no_touch
    @no_touch = true
  end

  def store_journey
    @list_of_journeys << {:entry_station => @entry_station, :exit_station => @exit_station}
  end

end
