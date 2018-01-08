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

end
