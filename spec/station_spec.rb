require 'station'

describe Station do
  let(:station) { Station.new("Bank", 1) }

  it "can be initialized with two arguements" do
    expect{ described_class.new("Bank", 1) }.not_to raise_error
  end
  it 'can expose the zone' do
    expect(station.zone).to eq(1)
  end
  it 'can expose the name' do
    expect(station.name).to eq("Bank")
  end
end
