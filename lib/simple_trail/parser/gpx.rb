# frozen_string_literal: true

module Parser
  class Gpx
    attr_reader :simplified_points, :points, :parsed_file

    def initialize(filename)
      @filename = filename
    end

    def read
      file = File.new(@filename)
      @parsed_file = XmlHasher.parse(file)[:gpx]
      extract_points
    end

    def meta
      @meta ||= extract_data
    end

    private

    def extract_points
      segments = @parsed_file.dig(:trk, :trkseg)
      @points = segments.is_a?(Array) ? segments.map { |seg| seg[:trkpt] }.flatten : segments[:trkpt]
      @simplified_points = @points.map { |point| point.select { |key, _| [:lon, :lat].include? key } }
    end

    def extract_data
      metadata = @parsed_file[:metadata]
      {
        name: metadata[:name],
        author: metadata[:author][:name]
      }
    end
  end
end
