require File.join(File.dirname(__FILE__), '..', "spec_helper")
require "rspec/matchers/dm/has_many"

describe DataMapperMatchers::HasMany do
  
  it "should pass for for working association" do
    Post.should has_many :comments
  end
  
  it "should fail if we expect existing relationships to not exist" do 
    lambda { Post.should_not has_many :comments }.should fail_with("has_many relationship comments exists, but was not expected")
  end
  
  it "should fail if a relationship simply doesn't exist" do
    lambda { Post.should has_many :sites }.should fail_with("has_many relationship sites does not exist for Post")
  end
  
end