require "oystercard"

describe Oystercard do

  let(:entry_station) {double :station}
  let(:exit_station) {double :station}

  let(:journey) {double :journey, :entry_station => entry_station, :exit_station => exit_station}
  subject(:subject) {described_class.new(journey)}

  let(:station) {double :station}

  it 'sets zero balance on new oystercard' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do

    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises error when balance excedes balance limit' do
      balance_limit = Oystercard::BALANCE_LIMIT
      subject.top_up(balance_limit)
      error = "Balance limit of #{balance_limit} reached"
      expect{subject.top_up(1)}.to raise_error error
    end
  end

  describe '#in_journey?' do
    let(:station) {double :station}
    before do
      subject.top_up(Oystercard::BALANCE_LIMIT)
    end

end

  describe '#touch_out'do
    let(:exit_station) {double :station}

    it "charges minimum fare" do
      subject.top_up(5)
      expect{ subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::MINIMUM_CHARGE)
    end
  end

  describe '#touch_in' do
    let(:station) {double :station}

    it 'raises error when touched in card has insufficient balance'do

    allow(journey).to receive(:start).with(station)

    expect{subject.touch_in(station)}.to raise_error 'Insufficient balance'
  end
  end

    describe 'journeys' do

      it 'checks if card has empty list of journeys by default'do
        expect(subject.journeys).to eq []
      end

      it 'stores a journey'do
        allow(journey).to receive(:start).with(entry_station) 
        subject.top_up(5)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.journeys).to include journey
      end
    end
  end
