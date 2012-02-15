# test_config.rb
#   Tests for SakaiInfo::Config
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-15 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'test/unit'
require 'sakai-info'
require 'tempfile'

class ConfigTest < Test::Unit::TestCase
  BadHashConfigs = [nil, {},
                    {"dbtype" => "mssql", "dbname" => "sakai", "dbuser" => "sakai",
                      "dbhost" => "sakai.db", "dbport" => 3306, "dbpass" => "12345"},
                    {"dbtype" => "oracle", "dbname" => "sakai", "dbuser" => "sakai",
                      "dbhost" => "sakai.db", "dbport" => 3306, "dbpass" => "12345"},
                    {"dbtype" => "mysql", "dbsid" => "sakai", "dbuser" => "sakai",
                      "dbpass" => "12345"}]

  GoodHashConfigs = [{"dbtype" => "mysql", "dbname" => "sakai", "dbuser" => "sakai",
                       "dbhost" => "sakai.db", "dbport" => 3306, "dbpass" => "12345"},
                     {"dbtype" => "oracle", "dbsid" => "sakai", "dbuser" => "sakai",
                       "dbpass" => "12345"}]

  # test SakaiInfo::Config.validate_config
  def test_validation
    # check bad configurations
    BadHashConfigs.each do |config_to_test|
      assert_equal(false, SakaiInfo::Config.validate_config(config_to_test))
    end

    # check well-formed configurations
    GoodHashConfigs.each do |config_to_test|
      assert_equal(true, SakaiInfo::Config.validate_config(config_to_test))
    end
  end

  # test SakaiInfo::Config.new with hashes
  def test_hash_loading
    # check bad configurations
    BadHashConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::InvalidConfigException) do
        SakaiInfo::Config.new(config_to_test)
      end
    end

    # check good configurations
    GoodHashConfigs.each do |config_to_test|
      assert_nothing_raised(SakaiInfo::InvalidConfigException) do
        config = SakaiInfo::Config.new(config_to_test)
        assert_equal(config.config, config_to_test)
      end
    end
  end

  # test SakaiInfo::Config.new with strings
  def test_string_loading
    # check bad configurations
    BadHashConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::InvalidConfigException) do
        SakaiInfo::Config.new(config_to_test.to_yaml)
      end
    end

    # check good configurations
    GoodHashConfigs.each do |config_to_test|
      assert_nothing_raised(SakaiInfo::InvalidConfigException) do
        config = SakaiInfo::Config.new(config_to_test.to_yaml)
        assert_equal(config.config, config_to_test)
      end
    end
  end

  # test SakaiInfo::Config.new with files
  def test_file_loading
    # check bad configurations
    BadHashConfigs.each do |config_to_test|
      tempfile = Tempfile.new("test_config.test_file_loading.bad-configs")
      tempfile.write(config_to_test.to_yaml)
      tempfile.close

      # check passing just the filename
      assert_raise(SakaiInfo::InvalidConfigException) do
        SakaiInfo::Config.new(tempfile.path)
      end

      # check passing an open file
      File.open(tempfile.path) do |f|
        assert_raise(SakaiInfo::InvalidConfigException) do
          SakaiInfo::Config.new(f)
        end
      end

      tempfile.unlink
    end

    # check good configurations
    GoodHashConfigs.each do |config_to_test|
      tempfile = Tempfile.new("test_config.test_file_loading.good-configs")
      tempfile.write(config_to_test.to_yaml)
      tempfile.close

      # check passing just the filename
      assert_nothing_raised(SakaiInfo::InvalidConfigException) do
        config = SakaiInfo::Config.new(tempfile.path)
        assert_equal(config.config, config_to_test)
      end

      # check passing an open file
      File.open(tempfile.path) do |f|
        assert_nothing_raised(SakaiInfo::InvalidConfigException) do
          config = SakaiInfo::Config.new(f)
          assert_equal(config.config, config_to_test)
        end
      end

      tempfile.unlink
    end
  end
end

