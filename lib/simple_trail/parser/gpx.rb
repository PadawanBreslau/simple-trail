# frozen_string_literal: true

module Parser
  class Gpx < Base
    attr_reader :simplified_points, :points, :points_of_interests, :parsed_file

    def initialize(filename)
      @filename = filename
    end

    def read
      file = File.new(@filename)
      @parsed_file = XmlHasher.parse(file)[:gpx]
      fail unless @parsed_file
      extract_points
      extract_pois
    end

    def meta
      @meta ||= extract_data
    end
  end
end
