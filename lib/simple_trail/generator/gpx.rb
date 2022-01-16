require 'nokogiri'

module Generator
  class Gpx
    attr_reader :output

    def initialize(points:, name: 'GPX file')
      @points = points
      @name = name
    end

    def time(xml, timestamp)
      xml.send(:time, timestamp)
    end

    def ele(xml, elevation)
      xml.send(:ele, elevation)
    end

    def gpx
      builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.gpx(version: '1.0') {
          xml.name { @name }
          xml.trk {
            xml.trkseg {
              @points.map do |point|
                xml.trkpt(lat: point[:lat], lon: point[:lon]) {
                  time(xml, point[:time]) unless point[:time].nil?
                  ele(xml, point[:ele]) unless point[:ele].nil?
                }
              end
            }
          }
        }
      end

      @output = builder.to_xml
    end
  end
end
