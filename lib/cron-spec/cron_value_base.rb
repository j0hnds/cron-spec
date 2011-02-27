module CronSpec

  class CronValueBase

    attr_reader :lower_limit, :upper_limit

    def initialize(lower_limit, upper_limit)
      @lower_limit = lower_limit
      @upper_limit = upper_limit

      raise "Lower limit must be less than or equal to upper limit" if @lower_limit > @upper_limit
    end

    def is_value_within_limits?(value)
      value >= @lower_limit && value <= upper_limit
    end
  end

end