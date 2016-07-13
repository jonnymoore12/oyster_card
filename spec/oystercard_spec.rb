require "oystercard"

describe Oystercard do

  let (:station){ double :station }

  it 'Has a default balance of 0' do
    expect(subject.balance).to eq 0
  end

  it "Can be topped up" do
    expect{ subject.top_up(10) }.to change{ subject.balance }.by 10
  end

  context 'When the card has sufficient balance' do
    before(:each) { subject.top_up(Oystercard::LIMIT) }

    it "Raises error when top up exceeds limit" do
      error = "Top up would exceed card limit of £#{Oystercard::LIMIT}"
      expect{ subject.top_up(1) }.to raise_error error
    end

    describe "#touch_in" do
      it "Can be touched in" do
        subject.touch_in(station)
        expect(subject.entry_station).to be station
      end
      it "Stores the entry station" do
        subject.touch_in(station)
        expect(subject.entry_station).to be station
      end
    end

    describe "#touch_out" do

      before(:each) { subject.touch_in(station) }

      it "Can be touched out" do
        subject.touch_out
        expect(subject.entry_station).to be nil
      end
      it "Deducts fare from balance" do
        subject.touch_out
        expect{ subject.touch_out }.to change{ subject.balance }.by -Oystercard::MIN_FARE
      end
      it "Resets the entry station to nil" do
        subject.touch_out
        expect(subject.entry_station).to be nil
      end

    end

    describe "#in_journey?" do
      it "Knows that we're in_journey after touch_in" do
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end

      it "Knows we're not in_journey after we touch_out" do
        subject.touch_in(station)
        subject.touch_out
        expect(subject).to_not be_in_journey
      end

      it "Not travelling if card hasn't been used" do
        expect(subject).to_not be_in_journey
      end
    end

  end

  it "Raises an error when balance is insufficient" do
    error = 'Insufficient balance'
    expect{ subject.touch_in(station) }.to raise_error error
  end

end
