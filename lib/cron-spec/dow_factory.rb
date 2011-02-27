module CronSpec
  class DowFactory < CronSpecificationFactory

    DayOfWeekLowerLimit = 0
    DayOfWeekUpperLimit = 6

    DaysOfWeek = %w{ sun mon tue wed thu fri sat }

    DayOfWeekExpression = DaysOfWeek.join('|')

    DayOfWeekSingleValuePattern = /\A(#{DayOfWeekExpression}|\d)\z/

    DayOfWeekRangePattern = /\A(#{DayOfWeekExpression}|\d)-(#{DayOfWeekExpression}|\d)\z/

    NamedDayOfWeekPattern = /\A(#{DayOfWeekExpression})\z/

    def initialize
      super
      @lower_limit = DayOfWeekLowerLimit
      @upper_limit = DayOfWeekUpperLimit
      @single_value_pattern = DayOfWeekSingleValuePattern
      @range_pattern = DayOfWeekRangePattern
    end

    private

    def convert_value(value)
      dow = (value =~ NamedDayOfWeekPattern) ? DaysOfWeek.index(value) : value.to_i
      # Sunday can be specified as index 7
      (dow == 7) ? 0 : dow
    end
  end
end