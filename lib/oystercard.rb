class Oystercard
attr_reader :balance


MAX_LIMIT = 90
MIN_LIMIT = 1

  def initialize
    @balance = 0
    @in_journey = false

  end

  def top_up(money)
    top_up_attempt = @balance + money
    message = "Limit of #{MAX_LIMIT} exceeded, can not top up the card."
    raise message if top_up_attempt > MAX_LIMIT
    @balance += money
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    message = "Insufficient funds. Must top up card."
    raise message if balance < MIN_LIMIT
    @in_journey = true
  end

  def touch_out
    deduct(MIN_LIMIT)
    @in_journey = false
  end


private
  
    def deduct(money)
      @balance -= money
    end

end
