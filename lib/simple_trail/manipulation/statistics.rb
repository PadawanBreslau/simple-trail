# frozen_string_literal: true

module Manipulation
  class Statistics
    def initialize(points)
      @points = points
    end

    def basic_statistics
      {
        distance: distance,
        ascent: ascent,
        descent: descent,
        time: time
      }
    end

    def distance
      latlng_points = @points.map { |p| Geokit::LatLng.new(p[:lat], p[:lon]) }
      (0..@points.size - 2).map do |i|
        latlng_points[i].distance_to(latlng_points[i + 1])
      end.inject(:+)
    end

    def ascent
      (0..@points.size - 2).map do |i|
        ascent_calc(@points[i], @points[i + 1])
      end.inject(:+)
    end

    def descent
      (0..@points.size - 2).map do |i|
        descent_calc(@points[i], @points[i + 1])
      end.inject(:+)
    end

    def time
      Time.parse(@points.last[:time]) - Time.parse(@points.first[:time])
    end

    def ascent_calc(start, finish)
      [0, finish[:ele].to_i - start[:ele].to_i].max
    end

    def descent_calc(start, finish)
      [0, start[:ele].to_i - finish[:ele].to_i].max
    end
  end
end
