module CronSpec
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

        def is_specification_in_effect?(time=Time.now.in_time_zone(DISPLAY_TIME_ZONE))
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
