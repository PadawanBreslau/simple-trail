require 'spec_helper'

RSpec.describe Parser::Gpx do
  it 'reads the file' do
    gpx_parser = described_class.new('./spec/examples/luk_karpat.gpx')
    expect { gpx_parser.read }.not_to raise_error
    expect(gpx_parser.parsed_file).not_to be_nil
    expect(gpx_parser.points.size).to eq 97352
    expect(gpx_parser.simplified_points.size).to eq 97352
  end
end
