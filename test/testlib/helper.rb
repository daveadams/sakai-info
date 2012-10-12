# testlib/helper.rb
#   Test support
#
# Created 2012-10-12 daveadams@gmail.com
# Last updated 2012-10-12 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'minitest/autorun'
require 'sakai-info'
include SakaiInfo

class Helper
  TestDatabaseFile = File.expand_path("../../tmp/db/test.db", File.dirname(__FILE__))

  def self.test_database_available?
    if File.exist? TestDatabaseFile
      DB.configure({:test => "sqlite://#{TestDatabaseFile}"})
      true
    else
      false
    end
  end
end

