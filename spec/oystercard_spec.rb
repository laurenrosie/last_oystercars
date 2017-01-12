require 'oystercard'
require 'journey'


describe Oystercard do
  describe '#balance' do
    it 'checks that the oystercard has a balance' do
      expect(subject).to respond_to(:balance)
    end
    it 'has an initial balance' do
      expect(subject.balance).to eql 0
    end
  end

  describe '#top_up' do
    it 'allows card to be topped up by a certain amount' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
    it 'the oystercard will accept a value and store it' do
      expect{subject.top_up Journey::MIN_FARE}.to change {subject.balance }.by (Journey::MIN_FARE)
    end
  end
  describe 'MAX_LIMIT' do
    it 'will raise an error if top up limit is exceeded' do
      subject.top_up(Oystercard::MAX_LIMIT)
      expect{subject.top_up(Journey::MIN_FARE)}.to raise_error("Limit of #{Oystercard::MAX_LIMIT} exceeded, can not top up the card.")
    end
  end

#deduct method made priavte so tests ommitted for now.

# describe '#deduct' do
#   it 'allows card to have balance deducted' do
#     expect(subject).to respond_to(:deduct).with(1).argument
#   end
# end
#
#   describe 'deduct money' do
#   it "will deduct the amount off the card" do
#     expect{subject.deduct (Journey::MIN_FARE)}.to change {subject.balance}.by (-Journey::MIN_FARE)
#   end
# end

  describe '#in_journey?' do
    it 'is initially not in journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    let(:entry_station){double :entry_station}

    context 'with min limit on balace' do
      before(:each) do
        subject.top_up(Journey::MIN_FARE)
      end
      it 'can touch in' do
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end
      it 'expect entry station to be recorded' do
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq entry_station
      end
    end
    context 'with 0 balance' do
      it 'raises error if not enough balance' do
        expect{subject.touch_in(entry_station)}.to raise_error("Insufficient funds. Must top up card.")
      end
    end
  end

  describe '#touch_out' do
    let(:entry_station){double :entry_station}
    let(:exit_station){double :exit_station}

    before(:each) do
      subject.top_up(Journey::MIN_FARE)
    end

    it 'can touch out' do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
    it 'to be charged when we touch out of our journey' do
      subject.touch_in(entry_station)
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by (-Journey::MIN_FARE)
    end
      # it 'changes entry_station to nil' do
      #   subject.touch_in(entry_station)
      #   subject.touch_out(exit_station)
      #   expect(subject.entry_station).to eq nil
      # end
  end

  describe "station_history_array" do
    before do
      entry_station = Station.new("Bank", 1)
      exit_station = Station.new("Tower Bridge", 1)
      subject.top_up(Journey::MIN_FARE)
    end

    it 'checks if the station_history is empty by default' do
      expect(subject.journey_history).to eq([])
    end

    context 'After touching in and out' do
      # before do
      #   subject.touch_in(entry_station)
      # end

      # it 'expect entry station to be recorded in station history' do
        # allow(subject).to receive(:station_history).and_return({ entry_station: "Bank"})
        # expect(subject.station_history).to eq(:entry_station => "Bank")
      # end
      it 'expect entry and exit station to be recorded in journey' do
        journey = Journey.new
        entry_station = Station.new("Bank", 1)
        exit_station = Station.new("Tower Bridge", 1)
        journey.entry_station = entry_station
        journey.exit_station = exit_station
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        # expect(subject.journey_history.first).to eq(journey)
        expect(subject.journey_history.first.entry_station.name).to eq(journey.entry_station.name)
        expect(subject.journey_history.first.exit_station.name).to eq(journey.exit_station.name)

      end

      # context 'and out' do
        # it 'checks that touching in and touching out creates one journey' do
        #   subject.touch_out(exit_station)
        #   allow(subject).to receive(:journey_log).and_return({ entry_station: "Bank" , exit_station: "Aldgate"})
        #   expect(subject.journey_log).to include(:entry_station => "Bank", :exit_station => "Aldgate")
        # end
      # end
    end
  end
end
