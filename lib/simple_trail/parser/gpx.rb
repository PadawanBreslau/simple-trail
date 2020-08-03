module Parser
  class Gpx
    attr_reader :meta, :simplified_points, :points, :parsed_file

    def initialize(filename)
      @filename = filename
    end

    def read
      file = File.new(@filename)
      @parsed_file = XmlHasher.parse(file)
      extract_points
    end

    private

    def meta
      @meta ||= extract_data
    end


    def extract_points

    end

    def extract_data
      @parsed_file

    end
  end
end
