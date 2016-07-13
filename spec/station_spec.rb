require 'station'

describe Station do

subject {described_class.new("Victoria",2)}

  it 'it has a name' do
    expect(subject.name).to eq("Victoria")
  end

  it 'has a zone' do
    expect(subject.zone).to eq(2)
  end
end
