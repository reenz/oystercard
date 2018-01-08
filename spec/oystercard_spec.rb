require "oystercard"

describe Oystercard do

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

  describe '#deduct' do

    it 'subtracts the fare from the balance' do
      subject.top_up(5)
      expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
    end
  end

  describe '#in_journey?' do
    before do
      subject.top_up(Oystercard::BALANCE_LIMIT)
    end

    it 'checks if oystercard is touched in'do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
end

  describe '#touch_out'do
    it 'checks if oystercard is touched out'do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
