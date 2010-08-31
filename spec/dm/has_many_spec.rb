require File.join(File.dirname(__FILE__), '..', "spec_helper")
require "rspec/matchers/dm/has_many"

class Source
  include DataMapper::Resource
  property :id, Serial
  property :title, String, :default=> ""

  has n, :tags
end

class Tag
  include DataMapper::Resource
  property :id, Serial
  
  belongs_to :source
end


describe DataMapperMatchers::HasMany do
  
  it "should pass for for working association" do
    Source.should has_many :tags
  end
  
  it "should fail if we expect existing relationships to not exist" do 
    lambda { Source.should_not has_many :tags }.should fail_with("has_many relationship tags exists, but was not expected")
  end
  
  it "should fail if a relationship simply doesn't exist" do
    lambda { Source.should has_many :sites }.should fail_with("has_many relationship sites does not exist for Source")
  end
  
end