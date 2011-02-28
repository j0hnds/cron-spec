module CronSpec

  ##
  # A single cron value
  #
  class SingleValueCronValue < CronValueBase

    attr_reader :single_value

    ##
    # Constructs a new SingleValueCronValue having the specified limits
    # and value. The value is checked to determine if it fits within the
    # specified limits; if it doesn't, an exception is raised.
    #
    def initialize(lower_limit, upper_limit, single_value)
      super(lower_limit, upper_limit)

      @single_value = single_value

      raise "Value is out of range: #{@single_value}" unless is_value_within_limits?(@single_value)
    end

    ##
    # Returns true if the specified value is equal to the value encapsulated
    # by the SingleValueCronValue.
    #
    def is_effective?(value)
      @single_value == value
    end

  end

end
