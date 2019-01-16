class OysterCard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MAX_BALANCE_ERROR = "Card limit of #{MAXIMUM_BALANCE} reached".freeze
  NO_FUNDS_ERROR = 'Insufficient funds'
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 3

  attr_reader :balance, :entry_station, :exit_station, :travel_history

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @travel_history = []
  end

  def top_up(amount)
    raise MAX_BALANCE_ERROR if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def check_balance
    # DEFAULT_BALANCE
  end

  def touch_in(station)
    @entry_station = station
    raise NO_FUNDS_ERROR if @balance < MINIMUM_BALANCE
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @exit_station = station
    @travel_history.push({in: entry_station, out: @exit_station})
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private :deduct
end
