class Oystercard
attr_reader :balance
attr_reader :entry_station
attr_reader :exit_station
attr_reader :journeys

BALANCE_LIMIT = 90
MINIMUM_BALANCE = 1
MINIMUM_CHARGE = 1

  def initialize
   @balance = 0
   @entry_station = nil
   @exit_station = nil
   @journeys = []
  end

  def top_up(amount)
    raise "Balance limit of #{BALANCE_LIMIT} reached" if amount +balance > BALANCE_LIMIT
    @balance += amount
  end


  def in_journey?
  @entry_station == nil ? false : true
  # @exit_station == nil ? true : false
  #!!entry_station
  end

  def touch_in(station)
    @entry_station = station
    fail "Insufficient balance" if @balance < MINIMUM_BALANCE
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    deduct(MINIMUM_CHARGE)
    @journeys << {entry_station: entry_station, exit_station: exit_station}
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
