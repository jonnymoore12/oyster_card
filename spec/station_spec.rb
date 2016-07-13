require 'station'

describe Station do

  subject {described_class.new(name: "Old Street", zone: 1)}

  it 'Should know its name' do
    expect(subject.name).to eq "Euston"
  end

  it 'Should have a zone on creation' do
    expect(subject.zone).to eq 1
  end

end
