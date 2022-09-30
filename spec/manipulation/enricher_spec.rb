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
    expect(enrichement_logic.enriched_points.all?{|point| !point[:ele].nil?}).to be(true)
  end

  it 'adds labels' do
    parser = Parser::Gpx.new('./spec/examples/gss20-full-official.gpx')
    parser.read

    enrichement_logic = described_class.new(parser.points, 0.1)
    enrichement_logic.enrich

    labels = enrichement_logic.enriched_points.map{|h| h[:label]}.compact.uniq
    expect(labels.size).to eq 506
    expect(labels.include?(1)).to be(true)
    expect(labels.include?(506)).to be(true)
    expect(labels.include?(507)).to be(false)
    expect(labels.include?(535)).to be(false)
  end

  it 'adds labels with offset' do
    parser = Parser::Gpx.new('./spec/examples/gss20-full-official.gpx')
    parser.read

    enrichement_logic = described_class.new(parser.points, 0.1, 50)
    enrichement_logic.enrich
    labels = enrichement_logic.enriched_points.map{|h| h[:label]}.compact.uniq
    expect(labels.size).to eq 506
    expect(labels.include?(1)).to be(false)
    expect(labels.include?(50)).to be(false)
    expect(labels.include?(51)).to be(true)
    expect(labels.include?(556)).to be(true)
  end
end
