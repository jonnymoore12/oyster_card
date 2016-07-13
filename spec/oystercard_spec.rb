require "oystercard"

describe Oystercard do

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

    it "Deduct the fare from the card" do
      expect{ subject.deduct(10) }.to change{ subject.balance }.by -10
    end

    it "Can be touched in" do
      expect(subject.touch_in).to eq true
    end

    it "Can be touched out" do
      subject.touch_in
      expect(subject.touch_out).to eq false
    end

    describe "#in_journey?" do
      it "knows that we're in_journey after touch_in" do
        subject.touch_in
        expect(subject).to be_in_journey
      end

      it "knows we're not in_journey after we touch_out" do
        subject.touch_in
        subject.touch_out
        expect(subject).to_not be_in_journey
      end

      it "not travelling if card hasn't been used" do
        expect(subject).to_not be_in_journey
      end
    end

  end

  it "Raises an error when balance is insufficient" do
    error = 'Insufficient balance'
    expect{ subject.touch_in }.to raise_error error
  end

end
