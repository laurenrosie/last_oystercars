require 'oystercard'


describe Oystercard do

  it 'checks that the oystercard has a balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'allows card to be topped up by a certain amount' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

end
