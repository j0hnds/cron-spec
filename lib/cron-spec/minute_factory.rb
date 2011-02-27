module CronSpec

  class MinuteFactory < CronSpecificationFactory

    MinuteLowerLimit = 0
    MinuteUpperLimit = 59

    def initialize
      super
      @lower_limit = MinuteLowerLimit
      @upper_limit = MinuteUpperLimit
    end

  end

end