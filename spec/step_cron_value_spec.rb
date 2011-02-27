require 'spec_helper'

describe CronSpec::StepCronValue do

  before(:each) do
    @cv = CronSpec::StepCronValue.new(0, 32, 2)
  end

  it "should indicate effective if the values match the step" do
    (0..32).each { | value | next unless (value % 2 == 0); @cv.is_effective?(value).should be true }
  end

  it "should indicate not effective if the values do not match the step" do
    (0..32).each { | value | next if (value % 2 == 0); @cv.is_effective?(value).should be false }
  end

end
