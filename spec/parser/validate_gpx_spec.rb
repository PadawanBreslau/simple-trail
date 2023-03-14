# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Parser::ValidateGpx do
  it 'validates a proper file' do
    gpx_validator = described_class.new('./spec/examples/test_1.gpx')
    expect(gpx_validator.validate_basics?).to be(true)
  end

  it 'returns false if improper file' do
    gpx_validator = described_class.new('./spec/examples/not_a_gpx.gpx')
    expect(gpx_validator.validate_basics?).to be(false)
  end
end
