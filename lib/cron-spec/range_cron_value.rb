module CronSpec

  ##
  # A cron value representing a range of values
  #
  class RangeCronValue < CronValueBase

    attr_reader :range_lower, :range_upper

    ##
    # Constructs a new RangeCronValue object. The object is initialized
    # with the value limits (lower_limit and upper_limit) and the 
    # defined sub-range of the lower/upper limits. 
    # 
    # The range_lower and range_upper values are checked to determine if
    # they are within the value limits and are not reversed. If they are not
    # within limits or reversed an exception is raised.
    #
    def initialize(lower_limit, upper_limit, range_lower, range_upper)
      super(lower_limit, upper_limit)
      @range_lower = range_lower
      @range_upper = range_upper

      raise "Invalid lower range value: #{@range_lower}" unless is_value_within_limits?(@range_lower)
      raise "Invalid upper range value: #{@range_upper}" unless is_value_within_limits?(@range_upper)
      raise "Lower limit must be less than or equal to the upper limit" if @range_lower > @range_upper
    end

    ##
    # Returns true if the specified value is with the range_upper/range_lower
    # value range, inclusive.
    #
    def is_effective?(value)
      @range_lower <= value && value <= @range_upper
    end

  end

end
