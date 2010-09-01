require File.join(File.dirname(__FILE__), '..', "spec_helper")
require "rspec/matchers/dm/has_validation"

describe DataMapperMatchers::HasValidation do
  
  it "should fail when missing the validation type" do
    Post.should has_validation :title, :validates_length_of, :within => (100..500)
    #lambda { Post.should has_validation :title }.should fail_with("validation type must be specified (ex: :validates_presence_of)")
  end
  
  #it "should pass for missing options" do
  #  Post.should has_validation :title, :validates_presence_of
  #end

  #it "should fail if we do not pass any options" do
  #  lambda { Post.should has_property :title, String }.should fail_with("field options must be specified")
  #end

  #it "should fail with improper property type" do
  #  lambda {Post.should has_property :title, Integer, :default => ""}.should fail_with("expected title to have type of Integer but has String")
  #end
end