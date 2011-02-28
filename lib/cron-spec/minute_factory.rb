module CronSpec

  ##
  # Factory for constructing minute cron values from a cron specification.
  #
  class MinuteFactory < CronSpecificationFactory

    # The lower limit of a value representing a minute of an hour
    MinuteLowerLimit = 0
    # The upper limit of a value representing a minute of an hour
    MinuteUpperLimit = 59

    ##
    # Constructs a new MinuteFactory object.
    def initialize
      super
      @lower_limit = MinuteLowerLimit
      @upper_limit = MinuteUpperLimit
    end

  end

end
