require 'journey'
#require 'pry'

TOP_UP_AMOUNT = 5

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

# Should there be some kind of test for greeting_message?
# It's a private method but it would be nice to test for some
# kind of output.

=begin
    it 'informs users when they double touch out' do
      expect(card.touch_out(exit_station)).to eq "You ballsed up your journey"
    end
  end
=end

  describe '#fare' do
    it 'returns the minimum fare when there is no penalty' do
      expect(subject.fare).to eq Oystercard::MINIMUM_FARE
    end
    it 'returns zero when we touch_in to begin a journey' do
      card.touch_in(entry_station)
      expect(card.journey.fare).to eq 0
    end
  end

end
