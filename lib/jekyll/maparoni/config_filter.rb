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

      def config
        @json["config"]
      end

      def name
        config["name"]
      end

      def emoji
        config["emoji"]
      end

      def description
        config["note"]
      end

      def has_schemas?
        !config["schemas"].nil?
      end

      def has_views?
        !config["views"].nil?
      end

      def schemas_count
        config["schemas"].nil? ? 0 : config["schemas"].count
      end

      def views_count
        config["views"].nil? ? 0 : config["views"].count
      end

      def url
        @json["url"].nil? ? json["request"]["url"] : @json["url"]
      end

      def format
        @json["importMode"].nil? ? "GeoJSON" : @json["importMode"]["type"]
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

  module MaparoniCollectionFilter
    class MaparoniCollectionDrop < Liquid::Drop
      def initialize(path)
        @json = JSON.parse(File.read(path))
      end

      def json
        @json
      end

      def config
        @json["maparoni"]
      end

      def name
        config["name"]
      end

      def emoji
        config["emoji"]
      end

      def description
        config["note"]
      end

      def has_schemas?
        !config["schemas"].nil?
      end

      def has_views?
        !config["views"].nil?
      end

      def schemas_count
        config["schemas"].nil? ? 0 : config["schemas"].count
      end

      def views_count
        config["views"].nil? ? 0 : config["views"].count
      end
    end

    def maparoni_collection(file)
      path = @context.registers[:site].source + file.path
      MaparoniCollectionDrop.new(path)
    end
  end

end