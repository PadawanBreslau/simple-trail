# frozen_string_literal: true

module Manipulation
  class Unifier
    attr_reader :unified_points

    def initialize(points, old_points)
      @points = points
      @old_points = old_points
    end

    def unify
      @unified_points = []
      average_point_location.each do |apl|
        possible_match = match_with_previous(apl)
        @unified_points << possible_match.nil? ? apl : possible_match
      end
    end

    private

    def average_point_location
      @result = []
      calculate_points_per_km
      @points.each_slice(@points_ratio) do |slice|
        @result << averaged_slice(slice)
      end
      @result
    end

    APPROXIMATION_DISTANCE = 0.1

    def match_with_previous(location)
      return unless @old_points

      @old_points.find do |op|
        Geokit::LatLng.new(op[:lat], op[:lon]).distance_to(
          Geokit::LatLng.new(location[:lat], location[:lon])
        ) < APPROXIMATION_DISTANCE
      end
    end

    SAMPLE_LENGTH = 0.2

    def calculate_points_per_km
      stats = Manipulation::Statistics.new(@points)
      @points_ratio = (@points.size * SAMPLE_LENGTH / stats.basic_statistics[:distance]).floor
    end

    def averaged_slice(slice)
      {
        lat: avg(slice, :lat),
        lon: avg(slice, :lon),
        ele: avg(slice, :ele),
        time: avg_time(slice)
      }
    end

    def avg(slice, key)
      return unless slice.first[key]

      slice.map { |point| point[key].to_f }.inject(:+) / slice.size
    end

    def avg_time(slice)
      return unless slice.first[:time]

      start_time = Time.parse slice.first[:time]
      end_time = Time.parse slice.last[:time]
      diff = end_time - start_time

      start_time + (diff / 2)
    end
  end
end
