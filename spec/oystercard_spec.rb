require 'oystercard'

describe Oystercard do

  it 'shows card balance' do
    expect(subject.balance).to eq 0
  end

  it 'in_journey returns false initially' do
    expect(subject).not_to be_in_journey
  end

  it 'can touch in' do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'can touch out' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  describe "#top_up" do
    it 'tops up balance' do
      expect{subject.top_up(10)}.to change {subject.balance}.by 10
    end

    it 'trial test' do
      limit = Oystercard::LIMIT
      subject.top_up(limit)
      expect{subject.top_up(1)}.to raise_error("limit #{limit} reached")
    end
  end

  describe "#deduct" do
    it 'deducts the fare amount from balance' do
      subject.top_up(100)
      expect{subject.deduct(50)}.to change {subject.balance}.by -50
    end

  end

end
