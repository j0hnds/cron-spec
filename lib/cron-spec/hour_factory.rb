module CronSpec

  ##
  # Factory for constructing hour cron values from a cron specification.
  #
  class HourFactory < CronSpecificationFactory

    # The lower limit of a value representing an hour of the day.
    HourLowerLimit = 0
    # The upper limit of a value representing an hour of the day.
    HourUpperLimit = 23

    ##
    # Constructs a new HourFactory object.
    #
    def initialize
      super
      @lower_limit = HourLowerLimit
      @upper_limit = HourUpperLimit
    end

  end

end
