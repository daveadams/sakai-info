# test_config.rb
#   Tests for SakaiInfo::Config
#
# Created 2012-02-15 daveadams@gmail.com
# Last updated 2012-02-19 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'test/unit'
require 'sakai-info'
require 'tempfile'

# inject an accessor into SakaiInfo::Config so tests will run
module SakaiInfo
  class Config
    attr_reader :config
  end
end

class ConfigTest < Test::Unit::TestCase
  # TODO: add tests for MultipleConfigExceptions
  # TODO: add bad port nums to InvalidConfigs
  InvalidConfigs =
    [nil, {},
     {"dbtype" => "mysql", "service" => "sakai", "username" => "sakai",
       "password" => "12345"},
     {"dbtype" => "oracle", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => 3306, "password" => "12345"}
    ]

  UnsupportedConfigs =
    [{"dbtype" => "mssql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => 3306, "password" => "12345"},
     {"dbtype" => "db2", "service" => "sakai", "username" => "sakai",
       "password" => "12345"}
    ]

  # TODO: add examples of valid multiple config to GoodConfigs listing
  # TODO: add all variations on oracle config to GoodConfigs listing
  # TODO: add port min and max--and missing--tests to GoodConfigs
  GoodConfigs =
    [{"dbtype" => "mysql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => 3306, "password" => "12345"},
     {"dbtype" => "oracle", "service" => "sakai", "username" => "sakai",
       "password" => "12345"}
    ]

  # test SakaiInfo::Config.validate_config
  def test_validation
    # check invalid configurations
    InvalidConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::InvalidConfigException) do
        SakaiInfo::Config.validate_config(config_to_test)
      end
    end

    # check 'unsupported' configurations
    UnsupportedConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::UnsupportedConfigException) do
        SakaiInfo::Config.validate_config(config_to_test)
      end
    end

    # check well-formed configurations
    GoodConfigs.each do |config_to_test|
      assert_nothing_raised do
        assert_equal(true, SakaiInfo::Config.validate_config(config_to_test))
      end
    end
  end

  # test SakaiInfo::Config.new with hashes
  def test_hash_loading
    # check invalid configurations
    InvalidConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::InvalidConfigException) do
        SakaiInfo::Config.new(config_to_test)
      end
    end

    # check unsupported configurations
    UnsupportedConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::UnsupportedConfigException) do
        SakaiInfo::Config.new(config_to_test)
      end
    end

    # check good configurations
    GoodConfigs.each do |config_to_test|
      assert_nothing_raised do
        config = SakaiInfo::Config.new(config_to_test)
        assert_equal(config.config, config_to_test)
      end
    end
  end

  # test SakaiInfo::Config.new with strings
  def test_string_loading
    # check invalid configurations
    InvalidConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::InvalidConfigException) do
        SakaiInfo::Config.new(config_to_test.to_yaml)
      end
    end

    # check unsupported configurations
    UnsupportedConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::UnsupportedConfigException) do
        SakaiInfo::Config.new(config_to_test.to_yaml)
      end
    end

    # check good configurations
    GoodConfigs.each do |config_to_test|
      assert_nothing_raised do
        config = SakaiInfo::Config.new(config_to_test.to_yaml)
        assert_equal(config.config, config_to_test)
      end
    end
  end

  # test SakaiInfo::Config.new with files
  def test_file_loading
    # check invalid configurations
    InvalidConfigs.each do |config_to_test|
      tempfile = Tempfile.new("test_config.test_file_loading.invalid-configs")
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

    # check unsupported configurations
    UnsupportedConfigs.each do |config_to_test|
      tempfile = Tempfile.new("test_config.test_file_loading.unsupported-configs")
      tempfile.write(config_to_test.to_yaml)
      tempfile.close

      # check passing just the filename
      assert_raise(SakaiInfo::UnsupportedConfigException) do
        SakaiInfo::Config.new(tempfile.path)
      end

      # check passing an open file
      File.open(tempfile.path) do |f|
        assert_raise(SakaiInfo::UnsupportedConfigException) do
          SakaiInfo::Config.new(f)
        end
      end

      tempfile.unlink
    end

    # check good configurations
    GoodConfigs.each do |config_to_test|
      tempfile = Tempfile.new("test_config.test_file_loading.good-configs")
      tempfile.write(config_to_test.to_yaml)
      tempfile.close

      # check passing just the filename
      assert_nothing_raised do
        config = SakaiInfo::Config.new(tempfile.path)
        assert_equal(config.config, config_to_test)
      end

      # check passing an open file
      File.open(tempfile.path) do |f|
        assert_nothing_raised do
          config = SakaiInfo::Config.new(f)
          assert_equal(config.config, config_to_test)
        end
      end

      tempfile.unlink
    end
  end
end

