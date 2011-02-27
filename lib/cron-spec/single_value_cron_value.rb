module CronSpec

  class SingleValueCronValue < CronValueBase

    attr_reader :single_value

    def initialize(lower_limit, upper_limit, single_value)
      super(lower_limit, upper_limit)

      @single_value = single_value

      raise "Value is out of range: #{@single_value}" unless is_value_within_limits?(@single_value)
    end

    def is_effective?(value)
      @single_value == value
    end

  end

end