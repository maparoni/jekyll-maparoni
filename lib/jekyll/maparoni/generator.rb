# frozen_string_literal: true

module Jekyll
  module Maparoni
    class Generator < Jekyll::Generator
      safe true
      priority :lowest

      def generate(site)
        @site = site
        site.collections.each do |name, collection|
          Jekyll.logger.info "Jekyll Maparoni:", "Generating geojson for #{name}"
          
          # Provide access to the markdown of the posts
          collection.docs.each do |post|
            post.data['raw_content'] = liquidify(post)
          end

          @site.pages << make_geojson(name, collection.metadata["title"])
        end
      end

      private

      def liquidify(post)
        info = {
          registers: { site: @site, page: post.to_liquid },
        }
        @site.liquid_renderer.file(post.path).parse(post.content).render!(@site.site_payload, info)
      end

      def make_geojson(collection, title)
        source_path = File.expand_path "maparoni.geojson", __dir__
        template = File.read(source_path)

        Jekyll::PageWithoutAFile.new(@site, __dir__, "", collection + ".geojson").tap do |file|
          file.content = template
          file.data["layout"] = nil
          file.data["collection"] = collection
          file.data["label"] = title # Don't use ["title"] or it might show up in the navigation!
          file
        end
      end
    end
  end
end
