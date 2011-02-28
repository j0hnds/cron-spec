module CronSpec

  ##
  # Defines an instance of a step value within a cron specification.
  #
  class StepCronValue < CronValueBase

    attr_reader :step_value

    ##
    # Constructs a new StepCronValue with the specified lower and upper limits
    # and step value. If the step value is 0 or is not less than or equal to
    # the upper limit, an exception is raised.
    #
    def initialize(lower_limit, upper_limit, step_value)
      super(lower_limit, upper_limit)

      @step_value = step_value

      raise "Invalid step value: #{@step_value}" if step_value == 0 || step_value > upper_limit
    end

    ##
    # Returns true if the specified value represents a value step value within
    # the step specification. Verifies that value % step_value == 0
    #
    def is_effective?(value)
      value % @step_value == 0
    end

  end

end
