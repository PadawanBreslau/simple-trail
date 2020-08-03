# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Parser::Gpx do
  it 'should read the file' do
    @gpx_parser = described_class.new('./spec/examples/test_1.gpx')
    expect {@gpx_parser.read}.not_to raise_error
    expect(@gpx_parser.parsed_file[:gpx]).not_to be_nil
  end
end
