class Oystercard
attr_reader :balance

MAX_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(money)
    top_up_attempt = @balance + money
    raise "Limit of #{MAX_LIMIT} exceeded, can not top up card." if top_up_attempt > MAX_LIMIT
    @balance += money

  end

end
