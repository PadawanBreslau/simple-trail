require 'spec_helper'

RSpec.describe Parser::Gpx do
  it 'reads poi' do
    gpx_parser = described_class.new('./spec/examples/pois.gpx')
    expect { gpx_parser.read }.not_to raise_error
    expect(gpx_parser.points_of_interests.size).to eq 6
  end
end
