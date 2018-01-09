require "oystercard"

describe Oystercard do

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

    it 'checks if oystercard is touched in'do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
end

  describe '#touch_out'do
    let(:exit_station) {double :station}
    it 'checks if oystercard is touched out'do
      #subject.touch_in
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it "charges minimum fare" do
      subject.top_up(5)
      expect{ subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::MINIMUM_CHARGE)
    end

    it 'stores nil when touched out'do
      subject.top_up(5)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
      # expect{subject.touch_out(exit_station)}.to change{subject.entry_station}.to nil
    end
  end

  describe '#touch_in' do
    let(:station) {double :station}

    it 'raises error when touched in card has insufficient balance'do
    expect{subject.touch_in(station)}.to raise_error 'Insufficient balance'
  end

    it 'stores the entry station'do
      subject.top_up(5)
      expect{subject.touch_in(station)}.to change{subject.entry_station}.to station
    end
  end

    describe 'journeys' do
      let(:entry_station) {double :station}
      let(:exit_station) {double :station}

      it "stores exit station"do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      #p subject.exit_station
      expect(subject.exit_station).to  eq exit_station
      end

      it 'checks if card has empty list of journeys by default'do
        expect(subject.journeys).to eq []
      end


    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

      it 'stores a journey'do
        subject.top_up(5)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.journeys).to include journey
      end
    end
  end
