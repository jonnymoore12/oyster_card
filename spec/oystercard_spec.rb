require 'oystercard'

describe Oystercard do
  it 'shows card balance' do
    expect(subject.balance).to eq 0
  end

  it 'tops up balance' do
    subject.top_up(10)
    expect(subject.balance).to eq 10
  end
end
