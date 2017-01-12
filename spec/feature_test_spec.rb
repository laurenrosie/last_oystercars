require 'oystercard'

describe "User stories" do
  let(:oystercard)  { Oystercard.new }
  let(:entry_station) {double "Station", :name => "Bank"}
  let(:exit_station)  {double "Station", :name => "London Bridge"}
# In order to use public transport
# As a customer
# I want money on my card
it 'so customer will check money on their card, card will start with balance 0' do
  expect(oystercard.balance).to eq 0
end
# In order to keep using public transport
# As a customer
# I want to add money to my card
it 'so customer can add money, card can be topped up' do
  expect{oystercard.top_up Oystercard::MIN_LIMIT}.to change {oystercard.balance }.by (Oystercard::MIN_LIMIT)
end

# In order to protect my money
# As a customer
# I don't want to put too much money on my card
it 'so customer doesn\'t put too much money on their card, card has a limit' do
  expect{oystercard.top_up(Oystercard::MAX_LIMIT + 1)}.to raise_error("Limit of #{Oystercard::MAX_LIMIT} exceeded, can not top up the card.")
end

# In order to pay for my journey
# As a customer
# I need my fare deducted from my card
  # xit 'so customer can be charged for the journey, card balance can be reduced' do
  #   oystercard.top_up(Oystercard::MIN_LIMIT * 2)
  #   expect{oystercard.deduct(Oystercard::MIN_LIMIT)}.to change {oystercard.balance }.to (Oystercard::MIN_LIMIT)
  # end

# In order to get through the barriers
# As a customer
# I need to touch in and out
it 'so customer can get through barriers, oystercard can be touched in and out' do
  oystercard.top_up Oystercard::MIN_LIMIT
  expect{oystercard.touch_in(entry_station)}.not_to raise_error
  expect{oystercard.touch_out(exit_station)}.not_to raise_error
end
context 'so customer can pay for journey' do
  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount for a single journey
  it 'oystercard has a minimum amount allowed for traveling' do
    expect{oystercard.touch_in(entry_station)}.to raise_error "Insufficient funds. Must top up card."
  end
  # In order to pay for my journey
  # As a customer
  # I need to pay for my journey when it's complete
  it 'oystercard is charged when journey is complete' do
    oystercard.top_up Oystercard::MIN_LIMIT
    expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.to(0)
  end
  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from
  it 'oystercard remembers the entry_station' do
    oystercard.top_up Oystercard::MIN_LIMIT
    expect{oystercard.touch_in(entry_station)}.to change{oystercard.entry_station}.to(entry_station)
  end
end
# In order to know where I have been
# As a customer
# I want to see to all my previous trips
it 'so customer knows where has been, oystercard tracks journeys' do
  oystercard.top_up Oystercard::MIN_LIMIT
  journey = {
    entry_station: entry_station, exit_station: exit_station
    }
  expect{oystercard.touch_in(entry_station)}.not_to raise_error
  expect{oystercard.touch_out(exit_station)}.not_to raise_error
  expect(oystercard.station_history_array.first).to eq(journey)
end
# In order to know how far I have travelled
# As a customer
# I want to know what zone a station is in

# Station class that exposes a name and a zone variable
it 'so customer knows where they have travelled, store station name and zone' do
  oystercard.top_up Oystercard::MIN_LIMIT
  entry_station = Station.new("Bank", 1)
  oystercard.touch_in(entry_station)
  expect(oystercard.entry_station.zone).to eq(1)
  expect(oystercard.entry_station.name).to eq("Bank")
end
# In order to be charged correctly
# As a customer
# I need a penalty charge deducted if I fail to touch in or out
#
# In order to be charged the correct amount
# As a customer
# I need to have the correct fare calculated

end
