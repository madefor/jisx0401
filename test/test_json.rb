require 'test/unit'
require './build.rb'

TMP_API_DIR = "tmp_api/"

class TestSample < Test::Unit::TestCase
  class << self
    def startup
    end

    def shutdown
    end
  end

  def setup
  end

  def test_build_json
    gen_pref_json(TMP_API_DIR)

    assert_equal(File.read(File.join(API_DIR,"jisx0401.json")),
                 File.read(File.join(TMP_API_DIR,"jisx0401.json")))
    assert_equal(File.read(File.join(API_DIR,"jisx0401-ja.json")),
                 File.read(File.join(TMP_API_DIR,"jisx0401-ja.json")))
    assert_equal(File.read(File.join(API_DIR,"jisx0401-en.json")),
                 File.read(File.join(TMP_API_DIR,"jisx0401-en.json")))
  end

  def teardown
    FileUtils.rm_rf(TMP_API_DIR)
  end
end
