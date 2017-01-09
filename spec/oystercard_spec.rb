require 'oystercard'


describe Oystercard do

  it 'checks that the oystercard has a balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'allows card to be topped up by a certain amount' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it 'will raise an error if top up limit (£90) is exceeded' do
    expect{subject.top_up(100)}.to raise_error("Limit of #{Oystercard::MAX_LIMIT} exceeded, can not top up card.")
  end

end
