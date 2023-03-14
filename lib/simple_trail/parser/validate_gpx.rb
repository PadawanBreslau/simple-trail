# frozen_string_literal: true

module Parser
  class ValidateGpx < Base
    def initialize(filename)
      @filename = filename
    end

    def validate_basics?
      file = File.new(@filename)
      @parsed_file = XmlHasher.parse(file)[:gpx]

      !@parsed_file.nil?
    end
  end
end
