require 'oystercard'

describe Oystercard do
  it 'shows card balance' do
    expect(subject.balance).to eq 0
  end
end
