require File.join(File.dirname(__FILE__), '..', "spec_helper")
require "rspec/matchers/dm/has_property"

describe DataMapperMatchers::HasProperty do
  it "should pass for missing options" do
    lambda { Post.should has_property :title, String, :default => "", :required => true }.should fail
  end

  it "should fail if we do not pass any options" do
    lambda { Post.should has_property :title, String }.should fail_with("field options must be specified")
  end

  it "should fail with improper property type" do
    lambda {Post.should has_property :title, Integer, :default => ""}.should fail_with("expected title to have type of Integer but has String")
  end
end