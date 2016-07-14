require 'oystercard'

describe Oystercard do
  it 'balance should equal 0' do
    expect(subject.balance).to eq 0
  end

let (:entrance_station) {double :station}
let (:exit_station) {double :station}

  describe '#top_up' do
    it 'can top up the balance' do
    expect{ subject.top_up 1}.to change{ subject.balance }.by 1
  end

  it 'raises an error when exceeds top up limit' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1}.to raise_error "Maximum balance of #{maximum_balance} reached"
    end
  end

  it 'charges on touch out' do
    expect{ subject.touch_out exit_station}.to change{ subject.balance }.by -Oystercard::MINIMUM_CREDIT
  end

  it 'enforces a minimum balance' do
    expect{subject.touch_in(entrance_station)}.to raise_error "No credit on card"
  end

end
