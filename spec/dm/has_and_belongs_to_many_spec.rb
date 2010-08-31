require File.join(File.dirname(__FILE__), '..', "spec_helper")
require "rspec/matchers/dm/has_and_belongs_to_many"

describe DataMapperMatchers::HasAndBelongsToMany do
  
  it "should pass for for working association" do
    Post.should has_and_belongs_to_many :tags
  end
  
  it "should fail if we expect existing relationships to not exist" do 
    #Post.should_not has_and_belongs_to_many :user
    lambda { Post.should_not has_and_belongs_to_many :tags }.should fail_with("has_and_belongs_to_many relationship tags exists, but was not expected")
  end
  
  it "should fail if a relationship simply doesn't exist" do
    lambda { Post.should has_and_belongs_to_many :sites }.should fail_with("has_and_belongs_to_many relationship sites does not exist for Post")
  end
  
end