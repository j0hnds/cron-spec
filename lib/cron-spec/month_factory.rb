module CronSpec

  ##
  # Factory for constructing month cron values from a cron specification.
  #
  class MonthFactory < CronSpecificationFactory

    # The lower limit for a value representing a month of a year
    MonthLowerLimit = 1
    # The upper limit for a value representing a month of a year
    MonthUpperLimit = 12

    # The supported names of the months
    Months = %w{ jan feb mar apr may jun jul aug sep oct nov dec }

    # A pipe-delimited list of the months of the year
    MonthExpression = Months.join('|')

    # A regular expression to match a single value month expression
    MonthSingleValuePattern = /\A(#{MonthExpression}|\d+)\z/

    # A regular expression to match a range month expression
    MonthRangePattern = /\A(#{MonthExpression}|\d+)-(#{MonthExpression}|\d+)\z/

    # A regular expression to match a named month
    NamedMonthPattern = /\A(#{MonthExpression})\z/

    ##
    # Constructs a new MonthFactory object.
    #
    def initialize
      super
      @lower_limit = MonthLowerLimit
      @upper_limit = MonthUpperLimit
      @single_value_pattern = MonthSingleValuePattern
      @range_pattern = MonthRangePattern
    end

    private

    def convert_value(value)
      (value =~ NamedMonthPattern) ? Months.index(value) + 1 : value.to_i
    end

  end
end
