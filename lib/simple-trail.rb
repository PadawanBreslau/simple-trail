# frozen_string_literal: true

require 'geokit'
require 'xmlhasher'

require File.expand_path('simple_trail/parser/gpx', __dir__)
require File.expand_path('simple_trail/manipulation/statistics', __dir__)
require File.expand_path('simple_trail/manipulation/straightener', __dir__)

module SimpleTrail
  Geokit.default_units = :kms
end
