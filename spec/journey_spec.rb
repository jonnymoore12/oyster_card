require 'journey'
#require 'pry'

TOP_UP_AMOUNT = 5

describe Journey do

  let (:entry_station) {double :station}
  let (:exit_station) {double :station}
  let (:journey) { {entry_station: entry_station, exit_station: exit_station }}


  it 'starts with an empty journey' do
    expect(subject.list_of_journeys).to be_empty
  end

  it 'responds to start_journey' do
    expect(subject).to respond_to :start_journey
  end

  it 'logs a journey' do
    card = Oystercard.new
    card.top_up TOP_UP_AMOUNT
    card.touch_in(entry_station)
    card.touch_out(exit_station)
    expect(card.journey.list_of_journeys).to include journey
  end

  it 'returns the minimum fare' do
    expect(subject.fare).to eq Oystercard::MINIMUM_FARE
  end

  context "without touch in or touch out" do
    it 'returns a penalty fare without touch in' do
      card = Oystercard.new
      card.touch_in(entry_station)
      card.touch_in(entry_station)
      expect(subject.fare).to eq "Penalty of £#{Journey::PENALTY_FARE} issued"
    end
  end

=begin
  it 'stores exit station' do
    subject.top_up TOP_UP_AMOUNT
    subject.touch_in(entrance_station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  it 'records entry station' do
    expect(subject.entrance_station).to eq (entrance_station)
  end

=end
end
