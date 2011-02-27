module CronSpec

  class HourFactory < CronSpecificationFactory

    HourLowerLimit = 0
    HourUpperLimit = 23

    def initialize
      super
      @lower_limit = HourLowerLimit
      @upper_limit = HourUpperLimit
    end

  end

end