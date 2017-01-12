require 'journey'

describe Journey do
  let (:journey) { Journey.new }
  it 'can save an entry station' do
    expect{journey.entry_station="Bank"}.not_to raise_error
  end
  it 'can save an exit station' do
    expect{journey.exit_station="Bank"}.not_to raise_error
  end

  describe '#fare' do
    it 'calculates fare with penalty if forgotten to touch in' do
      expect(journey.fare).to eq 6
    end
  end
end
