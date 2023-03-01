# frozen_string_literal: true

module Parser
  class ExtractPoints
    attr_reader :simplified_points, :points

    def initialize(parsed_file)
      @parsed_file = parsed_file
    end

    def read_points
      segments = @parsed_file.dig(:trk, :trkseg)
      @points = segments.is_a?(Array) ? segments.map { |seg| seg[:trkpt] }.flatten : segments[:trkpt]
      @simplified_points = @points.map { |point| point.select { |key, _| [:lon, :lat].include? key } }
    end
  end
end

