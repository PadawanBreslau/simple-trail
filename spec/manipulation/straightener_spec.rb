# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Manipulation::Straightener do
  it 'calculates basic file info' do
    parser = Parser::Gpx.new('./spec/examples/test_1.gpx')
    parser.read

    straigtener_logic = described_class.new(parser.points)
    straigtener_logic.points_without_clusters
  end
end
