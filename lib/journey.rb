require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_reader :list_of_journeys, :valid

  def initialize
    @list_of_journeys = []
    @valid = true
    @message = ''
  end


  def start_journey(entry_station)
    @message = ''
    penalty_message if @valid == false
    @entry_station = entry_station
    @valid = false
    @message
  end

  def end_journey(exit_station)
    @message = ''
    penalty_message if @valid == true
    @exit_station = exit_station
    @valid = true if @valid == false
    @valid = false if @valid == true
    store_journey
    @message
  end

  def fare
    if @valid == false
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
