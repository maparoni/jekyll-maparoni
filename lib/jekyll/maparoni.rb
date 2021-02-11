require "jekyll"
require "jekyll/maparoni/version"
require "jekyll/maparoni/generator"
require "jekyll/maparoni/config_filter"

Liquid::Template.register_filter(Jekyll::MaparoniGeoSubFilter)
Liquid::Template.register_filter(Jekyll::MaparoniCollectionFilter)