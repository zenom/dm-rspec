require File.join(File.dirname(__FILE__), '..', "spec_helper")
require "rspec/matchers/dm/has_timestamps"


describe DataMapperMatchers::HasTimestamps do
  
  it "should pass for having timestamps updated_at, created_at" do
    Post.should has_timestamps(:at)
  end
  
  it "should fail for having timestamps updated_on, created_on (not in model)" do
    lambda { Post.should has_timestamps(:on) }.should fail_with("expected Post to have created_on & updated_on columns, they don't exist")
  end
  
  it "should pass for specifying a specific column name" do
    Post.should has_timestamps(:created_at)
  end
  
  it "should fail for having a timestamp field that is not yet defined" do
    lambda { Post.should has_timestamps(:created_on) }.should fail_with("expected Post to have created_on columns, they don't exist")
  end

end