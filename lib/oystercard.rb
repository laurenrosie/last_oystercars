require 'journey'

class Oystercard
attr_reader :balance, :entry_station, :exit_station
attr_accessor :journey, :journey_history

MAX_LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
    @journey_history = []
  end

  def top_up(money)
    message = "Limit of #{MAX_LIMIT} exceeded, can not top up the card."
    raise message if @balance + money > MAX_LIMIT
    @balance += money
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    message = "Insufficient funds. Must top up card."
    raise message if balance < Journey::MIN_FARE
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    @in_journey = false
    journey_log
    deduct(@journey.fare)
  end

  def journey_log
    @journey = Journey.new
    @journey.entry_station = @entry_station
    @journey.exit_station = @exit_station
    @journey_history << @journey
  end

private
    def deduct(money)
      @balance -= money
    end

end
