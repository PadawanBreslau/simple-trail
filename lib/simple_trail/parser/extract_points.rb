# frozen_string_literal: true

module Parser
  class ExtractPoints
    attr_reader :simplified_points, :points

    def initialize(parsed_file)
      @parsed_file = parsed_file
    end

    def read_points

      main_node = @parsed_file.fetch(:trk)

      if main_node.is_a?(Array)
        @simplified_points = []
        @points = []

        main_node.each do |segment|
          @simplified_points << simplified_points_selection(segment)
          @points << segment_points_selection(segment)
        end

        @simplified_points.flatten!
        @points.flatten!
      else
        segments = main_node.fetch(:trkseg)
        @points = segments.is_a?(Array) ? segments.map { |seg| seg[:trkpt] }.flatten : segments[:trkpt]
        @simplified_points = @points.map { |point| point.select { |key, _| [:lon, :lat].include? key } }
      end
    end

    def segment_points_selection(segment)
      segments = segment.fetch(:trkseg)
      segments.is_a?(Array) ? segments.map { |seg| seg[:trkpt] }.flatten : segments[:trkpt]
    end

    def simplified_points_selection(segment)
      segment_points_selection(segment).map { |point| point.select { |key, _| [:lon, :lat].include? key } }
    end
  end
end

