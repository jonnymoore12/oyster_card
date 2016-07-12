require 'oystercard'
describe Oystercard do
  it 'shows card balance' do
    expect(Oystercard.new).to eq card
  end
end
