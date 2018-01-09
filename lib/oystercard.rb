class Oystercard
attr_reader :balance
attr_accessor :in_journey
BALANCE_LIMIT = 90
MINIMUM_BALANCE = 1
MINIMUM_CHARGE = 1
  def initialize
   @balance = 0
   @in_journey = false
  end

  def top_up(amount)
    raise "Balance limit of #{BALANCE_LIMIT} reached" if amount +balance > BALANCE_LIMIT
    @balance += amount
  end


  def in_journey?
   @in_journey
  end

  def touch_in
    fail "Insufficient balance" if @balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
