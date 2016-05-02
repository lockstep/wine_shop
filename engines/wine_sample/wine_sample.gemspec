# encoding: UTF-8

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'wine_sample'
  s.version     = '0.0.1'
  s.summary     = 'Sample data (including images) for use with Spree.'
  s.description = 'Same data for Get Wine Online'

  s.author      = 'Paul Hiatt'
  s.email       = 'paul@locksteplabs.com'
  s.homepage    = 'https://www.locksteplabs.com'
  s.license     = 'MIT'

  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'
end
