require 'oystercard'

describe Oystercard do
  it 'shows card balance' do
    expect(subject.balance).to eq 0
  end
  describe "#top_up" do
    it 'tops up balance' do
      expect{subject.top_up(10)}.to change {subject.balance}.by 10
    end
  end
end
