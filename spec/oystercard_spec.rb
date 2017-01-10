require 'oystercard'


describe Oystercard do

  it 'checks that the oystercard has a balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'allows card to be topped up by a certain amount' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it 'will raise an error if top up limit is exceeded' do
    expect{subject.top_up(100)}.to raise_error("Limit of #{Oystercard::MAX_LIMIT} exceeded, can not top up the card.")
  end

  it 'allows card to have balance deducted' do
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  it 'allows card to know whether it is in use or not' do
    expect(subject.in_journey?).to eq (true||false)
  end

  it 'changes the state of the card to "in journey"' do
    expect(subject.touch_in).to change(in_journey?).to(true)
  end

  it 'changes the state of the card to "not in journey"' do
    expect(subject.touch_out).to change(in_journey?).to(false)
  end

end
