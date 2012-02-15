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

class ConfigTest < Test::Unit::TestCase
  BadConfigs = [nil, {},
                {"dbtype" => "mssql", "dbname" => "sakai", "dbuser" => "sakai",
                  "dbhost" => "sakai.db", "dbport" => 3306, "dbpass" => "12345"},
                {"dbtype" => "oracle", "dbname" => "sakai", "dbuser" => "sakai",
                  "dbhost" => "sakai.db", "dbport" => 3306, "dbpass" => "12345"},
                {"dbtype" => "mysql", "dbsid" => "sakai", "dbuser" => "sakai",
                  "dbpass" => "12345"}]

  GoodConfigs = [{"dbtype" => "mysql", "dbname" => "sakai", "dbuser" => "sakai",
                   "dbhost" => "sakai.db", "dbport" => 3306, "dbpass" => "12345"},
                 {"dbtype" => "oracle", "dbsid" => "sakai", "dbuser" => "sakai",
                   "dbpass" => "12345"}]

  def test_validation
    # check bad configurations
    BadConfigs.each do |config_to_test|
      assert_equal(false, SakaiInfo::Config.validate_config(config_to_test))
    end

    # check well-formed configurations
    GoodConfigs.each do |config_to_test|
      assert_equal(true, SakaiInfo::Config.validate_config(config_to_test))
    end
  end
end

