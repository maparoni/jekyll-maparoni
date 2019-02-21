# Jekyll Maparoni plugin

A Jekyll plugin to generate a Maparoni-compatible GeoJSON collection of your Jekyll posts

**NOTE: This plugin is currently under active development, so use with caution.**

TODO: Add build + gem version badges


## Installation

Add this line to your site's Gemfile:

```ruby
gem 'jekyll-maparoni', git: 'https://gitlab.com/maparoni/jekyll-maparoni'
```

And then add this line to your site's `_config.yml`:

```yml
plugins:
  - jekyll-maparoni
```


## Usage

### Generating Maparoni Collections

First, add location information to your posts' YAML Front-matter:

```
location:
  latitude: -33.896103
  longitude: 151.274724
```

The plugin will then generate a Maparoni-compatible GeoJSON collection `/posts.geojson`.

### Reading Maparoni GeoSubs

This plugin also includes a `maparoni_geosub` filter for displaying information 
from Maparoni GeoSub files. Pass this filter a Jekyll static file and you then 
have access to the `name`, `description`, `url` and `has_schema?` properties.

For example, assuming that you keep the `.geosub` files in a `geosubs/` folder,
add the following to your `_config.yml`:

```
defaults:
  - scope:
      path: "geosubs"
    values:
      geosub: true
```

And then you can load and link the files as follows:

```
{% assign geosubs = site.static_files | where: "geosub", true %}
{% for sub in geosubs %}

{% assign config = sub | maparoni_geosub %}

- <strong>{{ config.name | strip }}</strong>: {{ config.description }}
  - {% if config.has_schemas? %}w/ widgets, {% endif %}[Download]({{ config.url }}), [Add to Maparoni](maparoni://import-collection?url={{ sub.path | absolute_url }})
  - Last update: {{ sub.modified_time | date_to_long_string: "ordinal" }}

{% endfor %}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://gitlab.com/maparoni/jekyll-maparoni. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## Code of Conduct

Everyone interacting in the Jekyll::Maparoni project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://gitlab.com/maparoni/jekyll-maparoni/blob/master/CODE_OF_CONDUCT.md).
