require 'journey'
#require 'pry'

TOP_UP_AMOUNT = 10

describe Journey do

  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) { {entry_station: entry_station, exit_station: exit_station }}
  let(:card) { Oystercard.new }
  before(:each) { card.top_up TOP_UP_AMOUNT }

  it 'starts with an empty journey' do
    expect(subject.list_of_journeys).to be_empty
  end

  it 'responds to start_journey' do
    expect(subject).to respond_to :start_journey
  end

  it 'logs a journey' do
    card.touch_in(entry_station)
    card.touch_out(exit_station)
    expect(card.journey.list_of_journeys).to include journey
  end

  context 'User forgets to touch in or out' do
    it 'charges the penalty fare for double touch in' do
      2.times { card.touch_in(entry_station) }
      expect(card.journey.fare).to eq Journey::PENALTY_FARE
    end
    it 'charges the penalty fare for double touch out' do
      2.times { card.touch_out(exit_station) }
      expect(card.journey.fare).to eq Journey::PENALTY_FARE
    end
  end

  describe '#fare' do
    it 'returns the minimum fare when there is no penalty' do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.journey.fare).to eq Oystercard::MINIMUM_FARE
    end
  end

end
