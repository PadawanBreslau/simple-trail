# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Manipulation::Unifier do
  it 'unifies when no previous points' do
    parser = Parser::Gpx.new('./spec/examples/test_1.gpx')
    parser.read

    unification_logic = described_class.new(parser.points, [])
    unification_logic.unify

    expect(unification_logic.unified_points.size).to eq 7
  end
end
