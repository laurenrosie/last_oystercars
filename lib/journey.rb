class Journey
  attr_accessor :entry_station, :exit_station

  MIN_FARE = 1
  PENALTY_FARE = 5

  def fare
    MIN_FARE + ( (@entry_station and @exit_station) ? 0 : PENALTY_FARE )
  end
end
