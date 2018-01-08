class Oystercard
attr_reader :balance
BALANCE_LIMIT = 90
  def initialize
   @balance = 0
  end

  def top_up(amount)
    raise "Balance limit of #{BALANCE_LIMIT} reached" if amount +balance > BALANCE_LIMIT
    @balance += amount
  end
<<<<<<< HEAD
=======

  def deduct(amount)
    @balance -= amount
  end

>>>>>>> d4f03ea6f26d7a0444a84e1726fd12c47f00605f
end
