require 'spec_helper'

describe CronSpec::CronSpecification do

  it "should honor the yearly shortcut value" do
    cs = CronSpec::CronSpecification.new("@yearly")

    # Verify that we will match if at midnight january 1st
    jan_1_00_00 = Time.new(2011, 1, 1, 0, 0, 0)
    cs.is_specification_in_effect?(jan_1_00_00).should be true

    # Verify that nothing else matches
    jan_1_00_10 = Time.new(2011, 1, 1, 0, 10, 0)
    cs.is_specification_in_effect?(jan_1_00_10).should be false
  end

  it "should honor the annually shortcut value" do
    cs = CronSpec::CronSpecification.new("@annually")

    # Verify that we will match if at midnight january 1st
    jan_1_00_00 = Time.new(2011, 1, 1, 0, 0, 0)
    cs.is_specification_in_effect?(jan_1_00_00).should be true

    # Verify that nothing else matches
    jan_1_00_10 = Time.new(2011, 1, 1, 0, 10, 0)
    cs.is_specification_in_effect?(jan_1_00_10).should be false
  end

  it "should honor the monthly shortcut value" do
    cs = CronSpec::CronSpecification.new("@monthly")

    # Verify that we will match if at midnight january 1st
    (1..12).each do |month|
      any_month_at_midnight = Time.new(2011, month, 1, 0, 0, 0)
      cs.is_specification_in_effect?(any_month_at_midnight).should be true
    end

    # Verify that nothing else matches
    jan_1_00_10 = Time.new(2011, 1, 2, 0, 10, 0)
    cs.is_specification_in_effect?(jan_1_00_10).should be false
  end

  it "should honor the weekly shortcut value" do
    cs = CronSpec::CronSpecification.new("@weekly")

    # It should honor every sunday
    (0..3).each do |week|
      sunday = Time.new(2011, 1, 2 + (week * 7), 0, 0, 0)
      cs.is_specification_in_effect?(sunday).should be true
    end
    # It should ignore every monday
    (0..3).each do |week|
      sunday = Time.new(2011, 1, 3 + (week * 7), 0, 0, 0)
      cs.is_specification_in_effect?(sunday).should be false
    end
  end

  it "should honor the daily shortcut value" do
    cs = CronSpec::CronSpecification.new("@daily")

    # It should honor every day of the week at midnight
    (1..20).each do |day|
      sunday = Time.new(2011, 1, day, 0, 0, 0)
      cs.is_specification_in_effect?(sunday).should be true
    end
    # It should ignore every day of the week at times other than midnight
    (1..20).each do |day|
      sunday = Time.new(2011, 1, day, 8, 0, 0)
      cs.is_specification_in_effect?(sunday).should be false
    end
  end

  it "should honor the midnight shortcut value" do
    cs = CronSpec::CronSpecification.new("@midnight")

    # It should honor every day of the week at midnight
    (1..20).each do |day|
      sunday = Time.new(2011, 1, day, 0, 0, 0)
      cs.is_specification_in_effect?(sunday).should be true
    end
    # It should ignore every day of the week at times other than midnight
    (1..20).each do |day|
      sunday = Time.new(2011, 1, day, 8, 0, 0)
      cs.is_specification_in_effect?(sunday).should be false
    end
  end

  it "should honor the hourly shortcut value" do
    cs = CronSpec::CronSpecification.new("@hourly")

    # It should honor every day of the week at midnight
    (0..23).each do |hour|
      sunday = Time.new(2011, 1, 1, hour, 0, 0)
      cs.is_specification_in_effect?(sunday).should be true
    end
    # It should ignore every day of the week at times other than midnight
    (0..23).each do |hour|
      sunday = Time.new(2011, 1, 1, hour, 10, 0)
      cs.is_specification_in_effect?(sunday).should be false
    end
  end

  it "should honor named days of the week" do
    cs = CronSpec::CronSpecification.new("* * * * mon,tue,thu-sat")

    # Make sure the correct days are honored
    [1, 2, 4, 5, 6].each do |dow|
#        next if dow == 4
      day = Time.new(2011, 1, 2 + dow, 11, 0, 0)
      cs.is_specification_in_effect?(day).should be true
    end

    # Make sure the bad days are ignored.
    [0, 3].each do |dow|
      day = Time.new(2011, 1, 2 + dow, 11, 0, 0)
      cs.is_specification_in_effect?(day).should be false
    end
  end
end
