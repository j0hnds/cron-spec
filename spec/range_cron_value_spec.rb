require 'spec_helper'

describe CronSpec::RangeCronValue do

  before(:each) do
    @cv = CronSpec::RangeCronValue.new(0, 16, 2, 12)
  end

  it "should indicate effective if value is within range" do
    (2..12).each { | value | @cv.is_effective?(value).should be true }
  end

  it "should indicate not effective if value is not within range" do
    (-1..1).each { | value | @cv.is_effective?(value).should be false }
    (13..16).each { | value | @cv.is_effective?(value).should be false }
  end

end