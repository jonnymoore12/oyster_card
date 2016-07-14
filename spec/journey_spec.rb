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

  it 'returns the minimum fare' do
    expect(subject.fare).to eq Oystercard::MINIMUM_FARE
  end

  context "without touch in or touch out" do

    it "returns penalty fare on double touch in" do
      card.touch_in(entry_station)
      card.touch_in(entry_station)
      expect(card.journey.fare).to eq "Penalty of £#{Journey::PENALTY_FARE} issued"
    end

    it "returns penalty fare on double touch in" do
      card.touch_out(entry_station)
      card.touch_out(entry_station)
      expect(card.journey.fare).to eq "Penalty of £#{Journey::PENALTY_FARE} issued"
    end
  end

end
