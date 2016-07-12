require 'oystercard'

describe Oystercard do
  it 'shows card balance' do
    expect(subject.balance).to eq 0
  end
  describe "#top_up" do
    it 'tops up balance' do
      expect{subject.top_up(10)}.to change {subject.balance}.by 10
    end
    it 'throws exeption when limit is exceeded' do
      limit = 150
      subject.top_up(limit)
      expect{subject.top_up(1)}.to raise_error 'limit reached'
    end
  end
end
