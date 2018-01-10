require_relative 'journey'

class Oystercard
attr_reader :balance,:journeys

BALANCE_LIMIT = 90
MINIMUM_BALANCE = 1
MINIMUM_CHARGE = 1

  def initialize(journey = Journey)
   @balance = 0
   @journeys = []
   @current_journey = journey
  end

  def top_up(amount)
    raise "Balance limit of #{BALANCE_LIMIT} reached" if amount +balance > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < MINIMUM_BALANCE
    @current_journey.start(station)
  end

  def touch_out(exit_station)
    @current_journey.end(exit_station)
    deduct(@current_journey.fare)
    @journeys << @current_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
