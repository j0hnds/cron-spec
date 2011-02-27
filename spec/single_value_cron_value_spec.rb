require 'spec_helper'

describe CronSpec::SingleValueCronValue do

  before(:each) do
    @cv = CronSpec::SingleValueCronValue.new(0, 32, 8)
  end

  it "should indicate effective if the value matches" do
    @cv.is_effective?(8).should be true
  end

  it "should indicate not effective if value does not match" do
    (-1..7).each { | value | @cv.is_effective?(value).should be false }
    (9..32).each { | value | @cv.is_effective?(value).should be false }
  end

end