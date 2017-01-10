class Oystercard
attr_reader :balance


MAX_LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false

  end

  def top_up(money)
    top_up_attempt = @balance + money
    raise "Limit of #{MAX_LIMIT} exceeded, can not top up the card." if top_up_attempt > MAX_LIMIT
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end


end
