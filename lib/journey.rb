require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_reader :list_of_journeys, :valid

  def initialize
    @list_of_journeys = []
    @message = ''
    @entry_count = 0
    @exit_count = 0
  end


  def start_journey(entry_station)
    @message = ''
    @exit_count = 0
    @entry_count += 1
    penalty_message if @entry_count > 1
    @entry_station = entry_station
    @message
  end

  def end_journey(exit_station)
    @message = ''
    @entry_count = 0
    @exit_count += 1
    penalty_message if @exit_count > 1
    @exit_station = exit_station
    store_journey
    @message
  end

  def fare
    if @entry_count > 1 || @exit_count > 1
      Journey::PENALTY_FARE
      # Additional method to bring up error message
    else
      Oystercard::MINIMUM_FARE
    end

  end

  private

  def store_journey
    @list_of_journeys << {:entry_station => @entry_station, :exit_station => @exit_station}
  end

  def penalty_message
    @message = "You ballsed up your journey"
  end

end
