module CronSpec

  ##
  # Base class for parsed cron values.
  #
  class CronValueBase

    attr_reader :lower_limit, :upper_limit

    ##
    # Constructs a new CronValueBase with the upper and lower limits of 
    # values allowed for this CronValue. For example, when definiting a
    # CronValue for a 'minute', the lower limit would be 0 and the upper
    # limit would be 59.
    #
    def initialize(lower_limit, upper_limit)
      @lower_limit = lower_limit
      @upper_limit = upper_limit

      raise "Lower limit must be less than or equal to upper limit" if @lower_limit > @upper_limit
    end

    ##
    # Returns true if the specified value is with the upper and lower 
    # limits defined for this CronValue.
    #
    def is_value_within_limits?(value)
      value >= @lower_limit && value <= upper_limit
    end
  end

end
