module CronSpec

  class StepCronValue < CronValueBase

    attr_reader :step_value

    def initialize(lower_limit, upper_limit, step_value)
      super(lower_limit, upper_limit)

      @step_value = step_value

      raise "Invalid step value: #{@step_value}" if step_value == 0 || step_value > upper_limit
    end

    def is_effective?(value)
      value % @step_value == 0
    end

  end

end