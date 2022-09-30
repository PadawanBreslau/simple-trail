# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'simple-trail'
  s.version     = '0.2.6'
  s.date        = '2020-08-03'
  s.summary     = 'Readind and manipulating GPX and other trail representation file'
  s.description = 'Optimazing and manipulating GPX file data. For my private purposes mostly'
  s.authors     = ['Staszek Zawadzki']
  s.email       = 'st.zawadzki@gmail.com'

  s.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.license       = 'MIT'
  s.add_dependency 'geokit', '1.13'
  s.add_dependency 'xmlhasher', '~> 1.0'
  s.add_dependency 'nokogiri', '~> 1.13'
  s.add_development_dependency 'pry', '~> 0.13'
  s.add_development_dependency 'rspec', '~> 3.9'
end
