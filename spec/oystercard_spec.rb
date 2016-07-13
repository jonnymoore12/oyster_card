require 'oystercard'

TOP_UP_AMOUNT = 5
DEDUCT_AMOUNT = 5

describe Oystercard do
 it 'balance should equal 0' do
     expect(subject.balance).to eq 0
 end

let (:entrance_station) {double :station}
let (:exit_station) {double :station}
let (:list_of_journeys) { {entrance_station: entrance_station, exit_station: exit_station }}

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

  it 'can touch out' do
    subject.top_up TOP_UP_AMOUNT
    subject.touch_in(entrance_station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end

  it 'charges on touch out' do
    expect{ subject.touch_out exit_station}.to change{ subject.balance }.by -Oystercard::MINIMUM_CREDIT
  end

  it 'starts with an empty journey' do
    expect(subject.list_of_journeys).to be_empty
  end

  it 'logs a journey' do
    subject.top_up TOP_UP_AMOUNT
    subject.touch_in(entrance_station)
    subject.touch_out(exit_station)
    expect(subject.list_of_journeys).to include list_of_journeys
  end

  it 'stores exit station' do
    subject.top_up TOP_UP_AMOUNT
    subject.touch_in(entrance_station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  it 'enforces a minimum balance' do
    expect{subject.touch_in(entrance_station)}.to raise_error "No credit on card"
  end

  context 'injourney' do

   before(:each) do
     subject.top_up TOP_UP_AMOUNT
     subject.touch_in(entrance_station)
   end

    it 'can touch in' do
     expect(subject).to be_in_journey
    end

    it 'records entry station' do
      expect(subject.entrance_station).to eq (entrance_station)
    end

  end
end
