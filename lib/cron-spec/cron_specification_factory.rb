module CronSpec

  ##
  # Base class for the definition of CronSpecificationFactory classes.
  #
  class CronSpecificationFactory

    WildcardPattern = /\A\*\z/
    SingleValuePattern = /\A(\d+)\z/
    RangePattern = /\A(\d+)-(\d+)\z/
    StepPattern = /\A\*\/(\d+)\z/

    ## 
    # Constructs a new CronSpecificationFactory
    #
    def initialize
      @single_value_pattern = SingleValuePattern
      @range_pattern = RangePattern
      @step_pattern = StepPattern
    end

    ##
    # Parses a unit of a cron specification.
    # The supported patterns for parsing are one of:
    # 
    # * Wildcard '*'
    # * Single Scalar Value [0-9]+|(sun|mon|tue|wed|thu|fri|sat)|(jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)
    # * Range value (0-9, mon-fri, etc.)
    # * Step value (*/[0-9]+)
    #
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
