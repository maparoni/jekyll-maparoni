# frozen_string_literal: true

require "json"

module Jekyll
  module MaparoniGeoSubFilter
    class MaparoniGeoSubDrop < Liquid::Drop
      def initialize(path)
        @json = JSON.parse(File.read(path))
      end

      def json
        @json
      end

      def name
        @json["config"]["name"]
      end

      def description
        @json["config"]["note"]
      end

      def has_schemas?
        !@json["config"]["schemas"].nil?
      end

      def url
        @json["url"]
      end
    end

    def maparoni_geosub(file)
      path = @context.registers[:site].source + file.path
      MaparoniGeoSubDrop.new(path)
    end
  end
end