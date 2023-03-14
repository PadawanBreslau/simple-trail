# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Parser::ValidateGpxString do
  it 'validates the string' do
    gpx_validator = described_class.new(File.new('./spec/examples/test_1.gpx').read)
    expect(gpx_validator.validate_basics?).to be(true)
  end

  it 'returns false if improper file' do
    gpx_validator = described_class.new(File.new('./spec/examples/not_a_gpx.gpx').read)
    expect(gpx_validator.validate_basics?).to be(false)
  end
end
