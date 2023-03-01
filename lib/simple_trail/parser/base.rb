# frozen_string_literal: true
module Parser
  class Base
    
    private

    def extract_points
      points_reader = ExtractPoints.new(@parsed_file)
      points_reader.read_points
      @points = points_reader.points
      @simplified_points = points_reader.simplified_points
    end

    def extract_pois
      @points_of_interests = @parsed_file[:wpt]
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
