module CronSpec

  ##
  # Represents a wildcard value
  #
  class WildcardCronValue < CronValueBase

    ##
    # Constructs a new WildcardCronValue with the specified limits.
    #
    def initialize(lower_limit, upper_limit)
      super(lower_limit, upper_limit)
    end

    ##
    # Returns true if the specified value is any value whatsoever.
    #
    def is_effective?(value)
      true
    end

  end

end
