$: << File.dirname(__FILE__) + "/../lib"
require "rspec"
require "dm-core"
require "data_mapper"

DataMapper.setup(:default, "sqlite3::memory:")

# must be initialized for include
module DataMapperMatchers
end

RSpec.configure do |config|
  config.include(DataMapperMatchers)
  config.before(:each) do
    DataMapper.auto_migrate!
  end
end

##############
# from rspec #
##############
module RSpec  
  module Matchers
    def fail
      raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    def fail_with(message)
      raise_error(RSpec::Expectations::ExpectationNotMetError, message)
    end
  end
end


class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :basic_field, String
  property :created_at, Date
  property :updated_at, Date

  belongs_to :user
  has n, :comments
  has n, :tags, :through => Resource
  
  validates_uniqueness_of :title#, :scope => :user
  validates_length_of :basic_field, :within => (100..500)
end

class User
 include DataMapper::Resource
 property :id, Serial
 
 has n, :posts
end

class Comment
  include DataMapper::Resource
  property :id, Serial
  
  belongs_to :post
end

class Tag
  include DataMapper::Resource
  property :id, Serial
  has n, :posts, :through => Resource
end