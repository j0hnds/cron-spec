module CronSpec
  class MonthFactory < CronSpecificationFactory

    MonthLowerLimit = 1
    MonthUpperLimit = 12

    Months = %w{ jan feb mar apr may jun jul aug sep oct nov dec }

    MonthExpression = Months.join('|')

    MonthSingleValuePattern = /\A(#{MonthExpression}|\d+)\z/

    MonthRangePattern = /\A(#{MonthExpression}|\d+)-(#{MonthExpression}|\d+)\z/

    NamedMonthPattern = /\A(#{MonthExpression})\z/

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