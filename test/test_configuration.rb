# test_configuration.rb
#   Tests for SakaiInfo::Configuration
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

# inject an accessor into SakaiInfo::Configuration so tests will run
module SakaiInfo
  class Configuration
    attr_reader :config
  end
end

class ConfigurationTest < Test::Unit::TestCase
  # TODO: add tests for MultipleConfigExceptions
  InvalidConfigs =
    [nil, {},
     {"dbtype" => "mysql", "service" => "sakai", "username" => "sakai",
       "password" => "12345"},
     {"dbtype" => "oracle", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => 3306, "password" => "12345"},
     {"dbtype" => "mysql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => 0, "password" => "12345"},
     {"dbtype" => "mysql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => 65536, "password" => "12345"},
     {"dbtype" => "mysql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => 99999, "password" => "12345"},
     {"dbtype" => "mysql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => -1, "password" => "12345"},
     {"dbtype" => "mysql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => -3306, "password" => "12345"},
     {"dbtype" => "oracle", "service" => "sakai", "username" => "sakai",
       "password" => "12345", "host" => "oracle.db", "port" => 0},
     {"dbtype" => "oracle", "service" => "sakai", "username" => "sakai",
       "password" => "12345", "host" => "oracle.db", "port" => 65536},
     {"dbtype" => "oracle", "service" => "sakai", "username" => "sakai",
       "password" => "12345", "host" => "oracle.db", "port" => 99999},
     {"dbtype" => "oracle", "service" => "sakai", "username" => "sakai",
       "password" => "12345", "host" => "oracle.db", "port" => -1},
     {"dbtype" => "oracle", "service" => "sakai", "username" => "sakai",
       "password" => "12345", "host" => "oracle.db", "port" => -1521}
    ]

  UnsupportedConfigs =
    [{"dbtype" => "mssql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => 3306, "password" => "12345"},
     {"dbtype" => "db2", "service" => "sakai", "username" => "sakai",
       "password" => "12345"}
    ]

  # TODO: add examples of valid multiple config to GoodConfigs listing
  GoodConfigs =
    [
     {"dbtype" => "mysql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => 3306, "password" => "12345"},
     {"dbtype" => "mysql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "password" => "12345"},
     {"dbtype" => "mysql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => 1, "password" => "12345"},
     {"dbtype" => "mysql", "dbname" => "sakai", "username" => "sakai",
       "host" => "sakai.db", "port" => 65535, "password" => "12345"},
     {"dbtype" => "oracle", "service" => "sakai", "username" => "sakai",
       "password" => "12345"},
     {"dbtype" => "oracle", "service" => "sakai", "username" => "sakai",
       "password" => "12345", "host" => "oracle.db"},
     {"dbtype" => "oracle", "service" => "sakai", "username" => "sakai",
       "password" => "12345", "host" => "oracle.db", "port" => 1251},
     {"dbtype" => "oracle", "service" => "sakai", "username" => "sakai",
       "password" => "12345", "host" => "oracle.db", "port" => 1},
     {"dbtype" => "oracle", "service" => "sakai", "username" => "sakai",
       "password" => "12345", "host" => "oracle.db", "port" => 65535}
    ]

  # test SakaiInfo::Configuration.validate_config
  def test_validation
    # check invalid configurations
    InvalidConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::InvalidConfigException) do
        SakaiInfo::Configuration.validate_config(config_to_test)
      end
    end

    # check 'unsupported' configurations
    UnsupportedConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::UnsupportedConfigException) do
        SakaiInfo::Configuration.validate_config(config_to_test)
      end
    end

    # check well-formed configurations
    GoodConfigs.each do |config_to_test|
      assert_nothing_raised do
        assert_equal(true, SakaiInfo::Configuration.validate_config(config_to_test))
      end
    end
  end

  # test SakaiInfo::Configuration.new with hashes
  def test_hash_loading
    # check invalid configurations
    InvalidConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::InvalidConfigException) do
        SakaiInfo::Configuration.new(config_to_test)
      end
    end

    # check unsupported configurations
    UnsupportedConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::UnsupportedConfigException) do
        SakaiInfo::Configuration.new(config_to_test)
      end
    end

    # check good configurations
    GoodConfigs.each do |config_to_test|
      assert_nothing_raised do
        config = SakaiInfo::Configuration.new(config_to_test)
        assert_equal(config.config, config_to_test)
      end
    end
  end

  # test SakaiInfo::Configuration.new with strings
  def test_string_loading
    # check invalid configurations
    InvalidConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::InvalidConfigException) do
        SakaiInfo::Configuration.new(config_to_test.to_yaml)
      end
    end

    # check unsupported configurations
    UnsupportedConfigs.each do |config_to_test|
      assert_raise(SakaiInfo::UnsupportedConfigException) do
        SakaiInfo::Configuration.new(config_to_test.to_yaml)
      end
    end

    # check good configurations
    GoodConfigs.each do |config_to_test|
      assert_nothing_raised do
        config = SakaiInfo::Configuration.new(config_to_test.to_yaml)
        assert_equal(config.config, config_to_test)
      end
    end
  end

  # test SakaiInfo::Configuration.new with files
  def test_file_loading
    # check invalid configurations
    InvalidConfigs.each do |config_to_test|
      tempfile = Tempfile.new("test_config.test_file_loading.invalid-configs")
      tempfile.write(config_to_test.to_yaml)
      tempfile.close

      # check passing just the filename
      assert_raise(SakaiInfo::InvalidConfigException) do
        SakaiInfo::Configuration.new(tempfile.path)
      end

      # check passing an open file
      File.open(tempfile.path) do |f|
        assert_raise(SakaiInfo::InvalidConfigException) do
          SakaiInfo::Configuration.new(f)
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
        SakaiInfo::Configuration.new(tempfile.path)
      end

      # check passing an open file
      File.open(tempfile.path) do |f|
        assert_raise(SakaiInfo::UnsupportedConfigException) do
          SakaiInfo::Configuration.new(f)
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
        config = SakaiInfo::Configuration.new(tempfile.path)
        assert_equal(config.config, config_to_test)
      end

      # check passing an open file
      File.open(tempfile.path) do |f|
        assert_nothing_raised do
          config = SakaiInfo::Configuration.new(f)
          assert_equal(config.config, config_to_test)
        end
      end

      tempfile.unlink
    end
  end
end

