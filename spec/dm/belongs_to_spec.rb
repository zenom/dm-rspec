require File.join(File.dirname(__FILE__), '..', "spec_helper")
require "rspec/matchers/dm/belongs_to"

describe DataMapperMatchers::BelongsTo do
  
  it "should pass for for working association" do
    Comment.should belongs_to(:post)
  end
  
  it "should fail for improper associations" do
   lambda { Comment.should_not belongs_to(:post) }.should fail_with("expected Comment to not have relation of post, exists")
  end
  
  it "should fail for non-existent model associations" do
    lambda { Post.should belongs_to(:sites) }.should fail_with("Sites model does not exist. (Reference: Post)")
  end
  
end