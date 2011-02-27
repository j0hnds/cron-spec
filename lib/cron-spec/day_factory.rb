module CronSpec
  class DayFactory < CronSpecificationFactory
    DayLowerLimit = 1
    DayUpperLimit = 31

    def initialize
      super
      @lower_limit = DayLowerLimit
      @upper_limit = DayUpperLimit
    end
  end
end