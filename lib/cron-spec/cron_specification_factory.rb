module CronSpec

  class CronSpecificationFactory

    WildcardPattern = /\A\*\z/
    SingleValuePattern = /\A(\d+)\z/
    RangePattern = /\A(\d+)-(\d+)\z/
    StepPattern = /\A\*\/(\d+)\z/

    def initialize
      @single_value_pattern = SingleValuePattern
      @range_pattern = RangePattern
      @step_pattern = StepPattern
    end

    def parse(value_spec)
      case value_spec
        when WildcardPattern
          WildcardCronValue.new(@lower_limit, @upper_limit)
        when @single_value_pattern
          SingleValueCronValue.new(@lower_limit, @upper_limit, convert_value($1))
        when @range_pattern
          RangeCronValue.new(@lower_limit, @upper_limit, convert_value($1), convert_value($2))
        when @step_pattern
          StepCronValue.new(@lower_limit, @upper_limit, $1.to_i)
        else
          raise "Unrecognized cron specification pattern."
      end
    end

    private

    def convert_value(value)
      value.to_i
    end

  end

end