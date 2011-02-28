module CronSpec
  ##
  # Factory for constructing Day CronValues from a cron specification.
  #
  class DayFactory < CronSpecificationFactory
    
    # The lower limit for a value representing a day of the month
    DayLowerLimit = 1
    # The upper limit for a value representing a day of the month
    DayUpperLimit = 31

    ##
    # Constructs a new DayFactory object.
    def initialize
      super
      @lower_limit = DayLowerLimit
      @upper_limit = DayUpperLimit
    end
  end
end
