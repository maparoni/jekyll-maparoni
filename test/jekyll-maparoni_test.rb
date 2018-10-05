require "test_helper"

class Jekyll::MaparoniTest < Minitest::Test
  SOURCE_DIR = File.expand_path("fixtures", __dir__)
  DEST_DIR   = File.expand_path("dest",     __dir__)

  def source_dir(*files)
    File.join(SOURCE_DIR, *files)
  end

  def dest_dir(*files)
    File.join(DEST_DIR, *files)
  end

  def setup
    overrides = {}
    config = Jekyll.configuration(Jekyll::Utils.deep_merge_hashes({
      "full_rebuild" => true,
      "source"       => source_dir,
      "destination"  => dest_dir,
      "show_drafts"  => true,
      "url"          => "http://example.org",
      "name"         => "My awesome site",
      "author"       => {
        "name" => "Dr. Jekyll",
      },
      "collections"  => {
        "my_collection" => { "output" => true },
        "other_things"  => { "output" => false },
      },
    }, overrides))

    @site = Jekyll::Site.new(config)
    @site.process

    @content = File.read(dest_dir("posts.geojson"))
  end

  def test_that_it_has_a_version_number
    refute_nil ::Jekyll::Maparoni::VERSION
  end

  def test_that_it_generated_a_geojson
    refute_nil @content
  end

  def test_it_has_no_layout
    refute_match /THIS IS MY LAYOUT/i, @content
  end

end
