require 'spec_helper'

describe CronSpec::WildcardCronValue do

  before(:each) do
    @cv = CronSpec::WildcardCronValue.new(0, 32)
  end

  it "should indicate effective for all values within limits" do
    (0..32).each { | value | @cv.is_effective?(value).should be true }
  end

end