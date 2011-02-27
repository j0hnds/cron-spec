module CronSpec

  class WildcardCronValue < CronValueBase

    def initialize(lower_limit, upper_limit)
      super(lower_limit, upper_limit)
    end

    def is_effective?(value)
      true
    end

  end

end