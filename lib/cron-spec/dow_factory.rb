module CronSpec

  ##
  # Factory for constructing Day of week values from a cron specification.
  #
  class DowFactory < CronSpecificationFactory

    # The lower limit for the value of a day of the week (0-Sunday)
    DayOfWeekLowerLimit = 0
    # The upper limit for the value of a day of the week (6-Saturday)
    DayOfWeekUpperLimit = 6

    # The supported names for the days of the week
    DaysOfWeek = %w{ sun mon tue wed thu fri sat }

    # A pipe-delimited expression for the days of the week
    DayOfWeekExpression = DaysOfWeek.join('|')

    # A regular expression that matches a single day of the week.
    DayOfWeekSingleValuePattern = /\A(#{DayOfWeekExpression}|\d)\z/

    # Regular expression that matches a range of days of the week
    DayOfWeekRangePattern = /\A(#{DayOfWeekExpression}|\d)-(#{DayOfWeekExpression}|\d)\z/

    # Regular expression that matches only a named day of the week.
    NamedDayOfWeekPattern = /\A(#{DayOfWeekExpression})\z/

    ##
    # Constructs a new DowFactory object.
    #
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
