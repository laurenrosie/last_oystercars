require 'oystercard'

describe "User stories" do
  let(:oystercard)  { Oystercard.new }

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
it 'so customer doesnt put too much money on their card, card has a limit' do
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
#
# In order to pay for my journey
# As a customer
# I need to have the minimum amount for a single journey
#
# In order to pay for my journey
# As a customer
# I need to pay for my journey when it's complete
#
# In order to pay for my journey
# As a customer
# I need to know where I've travelled from
#
# In order to know where I have been
# As a customer
# I want to see to all my previous trips
#
# In order to know how far I have travelled
# As a customer
# I want to know what zone a station is in
#
# In order to be charged correctly
# As a customer
# I need a penalty charge deducted if I fail to touch in or out
#
# In order to be charged the correct amount
# As a customer
# I need to have the correct fare calculated

end
