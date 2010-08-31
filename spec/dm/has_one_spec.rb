require File.join(File.dirname(__FILE__), '..', "spec_helper")
require "rspec/matchers/dm/has_one"

describe DataMapperMatchers::HasOne do
  
  it "should pass for for working association" do
    Post.should has_one :user
  end
  
  it "should fail if we expect existing relationships to not exist" do 
    lambda { Post.should_not has_one :user }.should fail_with("has_one relationship user exists, but was not expected")
  end
  
  it "should fail if a relationship simply doesn't exist" do
    lambda { User.should has_one :site }.should fail_with("has_one relationship site does not exist for User")
  end
  
end