# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Manipulation::Enricher do
  it 'nothing to enrich' do
    parser = Parser::Gpx.new('./spec/examples/test_1.gpx')
    parser.read

    point_count = parser.points.count
    enrichement_logic = described_class.new(parser.points)
    enrichement_logic.enrich

    expect(enrichement_logic.enriched_points.count).to eq point_count
  end

  it 'something to enrich' do
    parser = Parser::Gpx.new('./spec/examples/zyleta2021.gpx')
    parser.read

    point_count = parser.points.count
    enrichement_logic = described_class.new(parser.points)
    enrichement_logic.enrich

    expect(enrichement_logic.enriched_points.count).not_to eq point_count
  end

  it 'something more to enrich' do
    parser = Parser::Gpx.new('./spec/examples/gss20-full-official.gpx')
    parser.read

    point_count = parser.points.count
    enrichement_logic = described_class.new(parser.points, 0.1)
    enrichement_logic.enrich

    expect(enrichement_logic.enriched_points.count).not_to eq point_count
  end
end
