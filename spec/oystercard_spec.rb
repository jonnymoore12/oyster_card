require 'oystercard'

TOP_UP_AMOUNT = 5
DEDUCT_AMOUNT = 5

describe Oystercard do
 it 'balance should equal 0' do
     expect(subject.balance).to eq 0
 end

let (:station) {double :station}

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

  it 'is initially not in a journey' do
   expect(subject).not_to be_in_journey
  end

  it 'can touch in' do
   subject.top_up TOP_UP_AMOUNT
   subject.touch_in :station
   expect(subject).to be_in_journey
  end

  it 'can touch out' do
    subject.top_up TOP_UP_AMOUNT
    subject.touch_in :station
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'enforces a minimum balance' do
    expect{subject.touch_in :station}.to raise_error "No credit on card"
  end

  it 'charges on touch out' do
    expect{ subject.touch_out }.to change{ subject.balance }.by -Oystercard::MINIMUM_CREDIT
  end

  it 'records entry station' do
    subject.top_up TOP_UP_AMOUNT
    subject.touch_in (station)
    expect(subject.entry_station).to eq (station)
  end
end
