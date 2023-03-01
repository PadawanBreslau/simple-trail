# frozen_string_literal: true

require 'geokit'
require 'xmlhasher'

require File.expand_path('simple_trail/parser/base', __dir__)
require File.expand_path('simple_trail/parser/gpx', __dir__)
require File.expand_path('simple_trail/parser/gpx_string', __dir__)
require File.expand_path('simple_trail/parser/extract_points', __dir__)
require File.expand_path('simple_trail/manipulation/statistics', __dir__)
require File.expand_path('simple_trail/manipulation/straightener', __dir__)
require File.expand_path('simple_trail/manipulation/unifier', __dir__)
require File.expand_path('simple_trail/manipulation/enricher', __dir__)
require File.expand_path('simple_trail/generator/gpx', __dir__)

module SimpleTrail
  Geokit.default_units = :kms
end
