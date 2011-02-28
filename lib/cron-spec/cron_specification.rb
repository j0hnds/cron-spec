module CronSpec

  ##
  # Encapsulates the interpretation of a cron specification and 
  # provides a method which determines if the specified time is effective
  # with respect to the specification.
  #
  class CronSpecification

    TimeMethods = [ :min, :hour, :day, :month, :wday ]

    MINUTE = 0
    HOUR = 1
    DAY = 2
    MONTH = 3
    DOW = 4

    # Shortcut patterns
    YEARLY = 'yearly'
    ANNUALLY = 'annually'
    MONTHLY = 'monthly'
    WEEKLY = 'weekly'
    DAILY = 'daily'
    MIDNIGHT = 'midnight'
    HOURLY = 'hourly'

    SHORTCUT_CRONS = {
        YEARLY => '0 0 1 1 *',
        ANNUALLY => '0 0 1 1 *',
        MONTHLY => '0 0 1 * *',
        WEEKLY => '0 0 * * 0',
        DAILY => '0 0 * * *',
        MIDNIGHT => '0 0 * * *',
        HOURLY => '0 * * * *'}

    SHORTCUT_PATTERN = /\A@(#{SHORTCUT_CRONS.keys.join('|')})\z/

    attr_reader :raw_specification

    ##
    # Constructs a new CronSpecification with a textual cron specificiation.
    #
    # A broad cron syntax is supported:
    #
    #  *    *    *    *    *      
    #  -    -    -    -    -
    #  |    |    |    |    |
    #  |    |    |    |    +----- day of week (0 - 6) (Sunday=0)
    #  |    |    |    +---------- month (1 - 12)
    #  |    |    +--------------- day of month (1 - 31)
    #  |    +-------------------- hour (0 - 23)
    #  +------------------------- min (0 - 59)
    #
    # The following named entries can be used:
    #
    # * Day of week - sun, mon, tue, wed, thu, fri, sat
    # * Month - jan feb mar apr may jun jul aug sep oct nov dec
    #
    # The following constructs are supported:
    # 
    # * Ranges are supported (e.g. 2-10 or mon-fri)
    # * Multiple values are supported (e.g. 2,3,8 or mon,wed,fri)
    # * Wildcards are supported (e.g. *)
    # * Step values are supported (e.g. */4)
    # * Combinations of all but wildcard are supported (e.g. 2,*/3,8-10)
    #
    # A single space is required between each group.
    # 
    def initialize(raw_specification)
      raise "Must specify a cron specification" if raw_specification.nil?

      @raw_specification = (raw_specification =~ SHORTCUT_PATTERN) ? SHORTCUT_CRONS[$1] : raw_specification

      specification = @raw_specification.split(' ')
      raise "Invalid cron specification" if specification.size != 5

      @cron_values = []
      @cron_values << parse_specification(specification[MINUTE], MinuteFactory.new)
      @cron_values << parse_specification(specification[HOUR], HourFactory.new)
      @cron_values << parse_specification(specification[DAY], DayFactory.new)
      @cron_values << parse_specification(specification[MONTH], MonthFactory.new)
      @cron_values << parse_specification(specification[DOW], DowFactory.new)
    end

    ##
    # Return true if the specified time falls within the definition of the
    # CronSpecification. The parameter defaults to the current time.
    #
    def is_specification_in_effect?(time=Time.now)
      idx = 0
      test_results = @cron_values.collect do | cvalues |
        time_value = time.send(TimeMethods[idx])
        idx += 1
        !cvalues.detect { | cv | cv.is_effective?(time_value) }.nil?
      end.all?

    end

    private

    def parse_specification(specification, factory)
      specification.split(',').collect do |spec_component|
        factory.parse(spec_component)
      end
    end

  end

end
