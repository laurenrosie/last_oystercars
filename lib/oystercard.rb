class Oystercard
attr_reader :balance, :entry_station

MAX_LIMIT = 90
MIN_LIMIT = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
  end

  def top_up(money)
    top_up_attempt = @balance + money
    message = "Limit of #{MAX_LIMIT} exceeded, can not top up the card."
    raise message if top_up_attempt > MAX_LIMIT
    @balance += money
  end

  def in_journey?
    if entry_station == nil
      @in_journey = false
    else
      @in_journey = true
    end
  end

  def touch_in(entry_station)
    message = "Insufficient funds. Must top up card."
    raise message if balance < MIN_LIMIT
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out
    deduct(MIN_LIMIT)
    @in_journey = false
    @entry_station = nil
  end

  def entry_station
    @entry_station
  end

private
    def deduct(money)
      @balance -= money
    end

end
