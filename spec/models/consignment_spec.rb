require File.dirname(__FILE__) + '/../spec_helper'

describe Consignment do
  before(:each) do
    @consignment = Consignment.new
  end

  it "should be valid" do
    @consignment.should be_valid
  end
end
