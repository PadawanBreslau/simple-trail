# frozen_string_literal: true

module Manipulation
  class Enricher
    attr_reader :enriched_points

    def initialize(points)
      @points = points
      @counter = 3
    end

    def enrich
      add_points_where_big_gaps
      recalculate_distances
      add_total_distance
      add_km_markers

      @enriched_points = @points
    end

    private

    def add_points_where_big_gaps
      detect_gaps
      @gaps.any? ? points_with_gaps_field : @points
    end

    def points_with_gaps_field
      return @points if @gaps.none? || @counter.zero?

      offset = 0
      @gaps.each do |gap|
        middle_point = calculate_middle_point(@points[gap[:origin] + offset], @points[gap[:destination] + offset])
        @points = @points.insert(gap[:destination] + offset, {lat: middle_point.lat, lon: middle_point.lng })

        offset += 1
      end
      @counter -= 1
      add_points_where_big_gaps
    end

    def calculate_middle_point(loc1, loc2)
      latlan(loc1).midpoint_to(latlan(loc2))
    end

    GAP_LIMIT = 0.075
    def detect_gaps
      @gaps = []
      @points.each_cons(2).with_index do |pair, i|
        distance = calculate_distance(pair[0], pair[1])
        @gaps << {origin: i, destination: i+1, distance: distance} if distance > GAP_LIMIT
      end
    end

    def recalculate_distances
      @points.each_cons(2).with_index do |pair, i|
        distance = calculate_distance(pair[0], pair[1])
        @points[i+1].merge!(distance: distance)
      end
      @points[0].merge!(distance: 0.0)
    end

    def add_total_distance
      @points.each_with_index do |point, i|
        new_total = if i.zero?
                      point[:distance]
                    else !point[:distance].nil? && !@points[i-1][:total_distance].nil?
                      point[:distance] + @points[i-1][:total_distance]
                    end
        @points[i].merge!(total_distance: new_total)
      end
    end

    def add_km_markers
      total_distance = @points[-1][:total_distance].floor - 1
      total_distance.times do |i|
        find_and_enrich_first_occurence(i+1)
      end
    end

    def find_and_enrich_first_occurence(i)
      index = @points.find_index{|point| point[:total_distance] > i}
      @points[index].merge!(label: i)
    end

    def calculate_distance(loc1, loc2)
      return 0.0 if loc2.nil?
      latlan(loc1).distance_to(latlan(loc2))
    rescue
    end

    def latlan(location)
      Geokit::LatLng.new(location[:lat] || location['lat'], location[:lon] || location['lon'])
    rescue
    end
  end
end
