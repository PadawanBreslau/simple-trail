# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Generator::Gpx do
  it 'generates output' do
    parser = Parser::Gpx.new('./spec/examples/test_1.gpx')
    parser.read

    points = parser.points

    service = described_class.new(points: points)
    expect{service.gpx}.not_to raise_error
    output = service.output
    expect(output).not_to be_nil

    random_point = points.sample
    expect(output.match(/#{random_point[:lon]}/)).not_to be_nil
    expect(output.match(/#{random_point[:lat]}/)).not_to be_nil
  end

  it 'generates output when no time' do
    parser = Parser::Gpx.new('./spec/examples/test_no_time_and_ele.gpx')
    parser.read

    points = parser.points

    service = described_class.new(points: points)
    expect{service.gpx}.not_to raise_error
    output = service.output
    expect(output).not_to be_nil

    random_point = points.sample
    expect(output.match(/#{random_point[:lon]}/)).not_to be_nil
    expect(output.match(/#{random_point[:lat]}/)).not_to be_nil
    expect(output.match(/time/)).to be_nil
    expect(output.match(/ele/)).to be_nil
  end
end
