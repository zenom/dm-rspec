# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
GEM_NAME = "dm-rspec"
AUTHOR = "Andy Holman aka zenom"
EMAIL = "andy@zenjavi.com"
HOMEPAGE = "http://www.zenjavi.com"
SUMMARY = "RSpec2 matchers for DataMapper."
GEM_VERSION = "0.1.0"

spec = Gem::Specification.new do |s|
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.textile", "LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.require_path = 'lib'
  s.files = %w(LICENSE README.textile Rakefile) + Dir.glob("{lib,spec,app,public,stubs}/**/*")
end