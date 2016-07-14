require 'oystercard'

describe Oystercard do
  it 'balance should equal 0' do
    expect(subject.balance).to eq 0
  end

  let (:entry_station) {double :station}
  let (:exit_station) {double :station}

  describe '#top_up' do
    it 'can top up the balance' do
    expect{ subject.top_up(1) }.to change{ subject.balance }.by 1
  end

  it 'raises an error when top up would exceed limit' do
    subject.top_up(Oystercard::MAXIMUM_BALANCE)
    expect{ subject.top_up(1) }.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} reached"
    end
  end

  it 'charges on touch out' do
    expect{ subject.touch_out exit_station}.to change{ subject.balance }.by -Oystercard::MINIMUM_CREDIT
  end

  it "charges a penalty fare for double touch ins" do
    subject.top_up(Oystercard::MINIMUM_CREDIT)
    subject.touch_in(entry_station)
    expect{subject.touch_in(entry_station)}.to change{ subject.balance}.by -Journey::PENALTY_FARE
  end

  it "charges a penalty fare for double touch outs" do
    subject.touch_out(exit_station)
    expect{subject.touch_out(exit_station)}.to change{ subject.balance}.by -Journey::PENALTY_FARE
  end

  it 'enforces a minimum balance' do
    expect{subject.touch_in(entry_station)}.to raise_error "No credit on card"
  end

end
