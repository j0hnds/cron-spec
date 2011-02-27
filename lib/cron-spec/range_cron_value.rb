module CronSpec

  class RangeCronValue < CronValueBase

    attr_reader :range_lower, :range_upper

    def initialize(lower_limit, upper_limit, range_lower, range_upper)
      super(lower_limit, upper_limit)
      @range_lower = range_lower
      @range_upper = range_upper

      raise "Invalid lower range value: #{@range_lower}" unless is_value_within_limits?(@range_lower)
      raise "Invalid upper range value: #{@range_upper}" unless is_value_within_limits?(@range_upper)
      raise "Lower limit must be less than or equal to the upper limit" if @range_lower > @range_upper
    end

    def is_effective?(value)
      @range_lower <= value && value <= @range_upper
    end

  end

end