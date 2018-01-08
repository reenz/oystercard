require "oystercard"

describe Oystercard do

  it 'sets zero balance on new oystercard' do
    expect(subject.balance).to eq 0
  end
end
