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

      def emoji
        @json["config"]["emoji"]
      end

      def description
        @json["config"]["note"]
      end

      def has_schemas?
        !@json["config"]["schemas"].nil?
      end

      def has_views?
        !@json["config"]["views"].nil?
      end

      def schemas_count
        @json["config"]["schemas"].nil? ? 0 : @json["config"]["schemas"].count
      end

      def views_count
        @json["config"]["views"].nil? ? 0 : @json["config"]["views"].count
      end

      def url
        @json["url"]
      end

      def source_html
        "<a href=\"#{@json["source"]["url"]}\">#{@json["source"]["name"]}</a>"
      end

      def source_markdown
        "[#{@json["source"]["name"]}](#{@json["source"]["url"]})"
      end
    end

    def maparoni_geosub(file)
      path = @context.registers[:site].source + file.path
      MaparoniGeoSubDrop.new(path)
    end
  end
end