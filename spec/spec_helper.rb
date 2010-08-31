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
  property :title, String, :default=> ""

  has 1, :user
  has n, :comments
end

class User
 include DataMapper::Resource
 property :id, Serial
 
 belongs_to :post
end

class Comment
  include DataMapper::Resource
  property :id, Serial
  
  belongs_to :post
end