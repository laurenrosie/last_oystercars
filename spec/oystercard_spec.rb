require 'Oystercard'

describe Oystercard do
  it 'checks that the oystercard has a balance' do
    expect(subject).to respond_to(:balance)
  end

end
