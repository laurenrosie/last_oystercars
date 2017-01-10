require 'oystercard'


describe Oystercard do

describe '#balance' do
  it 'checks that the oystercard has a balance' do
    expect(subject).to respond_to(:balance)
    expect(subject.balance).to eq(0)
  end

end

describe 'initial balance'
it 'has an initial balance' do
  expect(subject.balance).to eql 0
end

describe '#top_up'
  it 'allows card to be topped up by a certain amount' do
    expect(subject).to respond_to(:top_up).with(1).argument
    expect{subject.top_up 10}.to change {subject.balance }.by 10
  end

  describe '#MAX_LIMIT'
  it 'will raise an error if top up limit is exceeded' do
    subject.top_up(Oystercard::MAX_LIMIT)
    expect{subject.top_up(1)}.to raise_error("Limit of #{Oystercard::MAX_LIMIT} exceeded, can not top up the card.")
  end

describe '#deduct'
  it 'allows card to have balance deducted' do
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  describe 'deduct money'
  it "will deduct the amount off the card" do
    expect{subject.deduct 10}.to change {subject.balance}.by -10
  end

describe 'in_journey'
  it 'is initially not in journey' do
    expect(subject).not_to be_in_journey
  end

  describe 'touch_in' do
  it 'can touch in' do
    subject.touch_in
    expect(subject).to be_in_journey
  end
end

describe 'tocuh_out'
  it 'can touch out' do
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

end
