class Oystercard
attr_reader :balance
attr_accessor :in_journey
attr_reader :entry_station
BALANCE_LIMIT = 90
MINIMUM_BALANCE = 1
MINIMUM_CHARGE = 1
  def initialize
   @balance = 0
   @entry_station = nil
  end

  def top_up(amount)
    raise "Balance limit of #{BALANCE_LIMIT} reached" if amount +balance > BALANCE_LIMIT
    @balance += amount
  end


  def in_journey?
  @entry_station == nil ? false : true
  #!!entry_station
  end

  def touch_in(station)
    @entry_station = station
    fail "Insufficient balance" if @balance < MINIMUM_BALANCE
  end

  def touch_out(station)
    @entry_station = station
    @entry_station = nil
    deduct(MINIMUM_CHARGE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
