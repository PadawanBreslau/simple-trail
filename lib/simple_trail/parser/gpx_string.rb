# frozen_string_literal: true
module Parser
  class GpxString < Base
    attr_reader :simplified_points, :points, :points_of_interests, :parsed_file

    def initialize(file_content)
      @file_content = file_content
    end

    def read
      @parsed_file = XmlHasher.parse(@file_content)[:gpx]
      fail unless @parsed_file
      extract_points
      extract_pois
    end

    def meta
      @meta ||= extract_data
    end
  end
end
