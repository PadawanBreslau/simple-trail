# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Parser::Gpx do
  it 'reads the file' do
    gpx_parser = described_class.new('./spec/examples/test_1.gpx')
    expect { gpx_parser.read }.not_to raise_error
    expect(gpx_parser.parsed_file).not_to be_nil
  end

  it 'reads metadata' do
    gpx_parser = described_class.new('./spec/examples/test_1.gpx')
    gpx_parser.read

    expect(gpx_parser.meta[:author]).to eq 'choosen'
    expect(gpx_parser.meta[:name]).to eq '06.06.2020 18:56'
  end

  it 'reads points simplified/all' do
    gpx_parser = described_class.new('./spec/examples/test_1.gpx')
    gpx_parser.read
    expect(gpx_parser.points.size).to eq 190
    expect(gpx_parser.points.size).to eq gpx_parser.simplified_points.size

    random_index = rand(gpx_parser.points.size)
    expect(gpx_parser.points[random_index][:lat]).to eq gpx_parser.simplified_points[random_index][:lat]
    expect(gpx_parser.points[random_index][:lon]).to eq gpx_parser.simplified_points[random_index][:lon]
  end

  it 'reads file with segments' do
    gpx_parser = described_class.new('./spec/examples/test_with_segments.gpx')
    expect { gpx_parser.read }.not_to raise_error

    expect(gpx_parser.points.size).to eq 355
  end
end
