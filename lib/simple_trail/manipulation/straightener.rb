# frozen_string_literal: true

module Manipulation
  class Straightener
    attr_reader :points, :cluster_groups

    def initialize(points)
      @points = points
      @latlng_points = @points.map { |p| Geokit::LatLng.new(p[:lat], p[:lon]) }
    end

    def points_without_clusters
      @average_distance_between ||= average_distance_between
      @possible_clusters = detect_clusters
      straighten_points!
    end

    def cluster_groups
      @cluster_groups ||= group_clusters
    end

    private

    BASIC_SAMPLE_SIZE = 100
    BASIC_CLUSTER_CHECK_SIZE = 10
    BASIC_CLUSTER_CHECK_RATIO = 0.3

    def group_clusters
      @cluster_groups = []
      @possible_clusters.each do |index|
        @group ||= []
        if index.nil?
          unless @group.empty?
            @cluster_groups << @group
            @group = []
          end
          next
        else
          @group << index
        end
      end
      @cluster_groups << @group unless @group.empty?
    end

    def straighten_points!
      cluster_groups.each do |cluster_group|
        cluster_coords = @points.values_at(*cluster_group)
        avg_lat = cluster_coords.map { |cc| cc[:lat].to_f }.inject(:+) / cluster_coords.size
        avg_lon = cluster_coords.map { |cc| cc[:lon].to_f }.inject(:+) / cluster_coords.size
        @points[cluster_group.first][:lat] = avg_lat.to_s
        @points[cluster_group.first][:lon] = avg_lon.to_s
        cluster_group.drop(1).each { |index| @points.delete_at(index) }
      end
    end

    def average_distance_between
      sample_points = (0..@points.size - 2).to_a.sample(BASIC_SAMPLE_SIZE)
      sample_points.map do |i|
        start = @latlng_points[i]
        finish = @latlng_points[i + 1]
        start.distance_to(finish)
      end.inject(:+) / sample_points.size
    end

    def detect_clusters
      (0..@points.size - BASIC_CLUSTER_CHECK_SIZE - 1).to_a.map do |i|
        start = @latlng_points[i]
        finish = @latlng_points[i + BASIC_CLUSTER_CHECK_SIZE]
        distance = start.distance_to(finish)
        i if distance < @average_distance_between * BASIC_CLUSTER_CHECK_SIZE * BASIC_CLUSTER_CHECK_RATIO
      end
    end
  end
end
