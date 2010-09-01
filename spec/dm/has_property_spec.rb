require File.join(File.dirname(__FILE__), '..', "spec_helper")
require "rspec/matchers/dm/has_property"

describe DataMapperMatchers::HasProperty do
  it "should pass with the property type" do
   Post.should has_property :title, String
  end

  it "should fail with improper property type" do
    lambda {Post.should has_property :title, Integer}.should fail_with("expected title to have type of Integer but has String")
  end
  
end