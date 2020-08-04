# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Manipulation::Statistics do
  it 'should calculate basic file info' do
    parser = Parser::Gpx.new('./spec/examples/test_1.gpx')
    parser.read

    statistics_logic = described_class.new(parser.points)
    expect(statistics_logic.distance).to eq 1.3221312287173086
    expect(statistics_logic.ascent).to eq 154
    expect(statistics_logic.descent).to eq 67
    expect(statistics_logic.time).to eq 1464.0
  end
end
