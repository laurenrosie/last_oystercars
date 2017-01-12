class Oystercard
attr_reader :balance, :entry_station, :exit_station
attr_accessor :station_history_array, :station_history

MAX_LIMIT = 90
MIN_LIMIT = 1

  def initialize
    @balance = 0
    @in_journey = false
    @station_history_array = []
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
    raise message if balance < MIN_LIMIT
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_LIMIT)
    @exit_station = exit_station
    @in_journey = false
    journey_log
  end

  def journey_log
    station_history = Hash.new
    station_history[:entry_station] = @entry_station
    station_history[:exit_station] = @exit_station
    @station_history_array << station_history
  end

private
    def deduct(money)
      @balance -= money
    end

end
