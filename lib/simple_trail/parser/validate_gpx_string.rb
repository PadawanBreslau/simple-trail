# frozen_string_literal: true

module Parser
  class ValidateGpxString < Base
    def initialize(file_content)
      @file_content = file_content
    end

    def validate_basics?
      @parsed_file = XmlHasher.parse(@file_content)[:gpx]

      !@parsed_file.nil?
    end
  end
end
