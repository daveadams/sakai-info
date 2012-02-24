# test_bin.rb
#   Direct tests for bin/sakai-info
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-02-24 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'test/unit'
require 'sakai-info/version'

# open3 library is used to capture stdout, stderr, and the exit value
require 'open3'

class BinTest < Test::Unit::TestCase
  CLI_ENV = { "RUBYLIB" => "lib" }
  COMMAND = "bin/sakai-info"

  # test with no command line arguments
  #  $ sakai-info
  def test_empty
    Open3.popen3(CLI_ENV, "#{COMMAND}") do |stdin, stdout, stderr, wait_thread|
      # stdout ought to be empty
      assert_equal("", stdout.readlines.join)

      # stderr ought to match what's given here
      # TODO: pull strings directly from CLI class
      assert_equal("ERROR: No command was given.\nRun 'sakai-info help' for a list of commands.\n",
                   stderr.readlines.join)

      # exit code ought to be 1
      assert_equal(1, wait_thread.value.exitstatus)
    end
  end

  # $ sakai-info help
  def test_help
    Open3.popen3(CLI_ENV, "#{COMMAND} help") do |stdin, stdout, stderr, wait_thread|
      # stdout should match string from CLI::Help
      assert_equal(SakaiInfo::CLI::Help::STRINGS[:default], stdout.readlines.join)

      # stderr ought to be empty
      assert_equal("", stderr.readlines.join)

      # exit code ought to be 0
      assert_equal(0, wait_thread.value.exitstatus)
    end

    %w(help version test).each do |topic|
      Open3.popen3(CLI_ENV, "#{COMMAND} help #{topic}") do |stdin, stdout, stderr, wait_thread|
        # stdout should match string from CLI::Help
        assert_equal(SakaiInfo::CLI::Help::STRINGS[topic], stdout.readlines.join)

        # stderr ought to be empty
        assert_equal("", stderr.readlines.join)

        # exit code ought to be 0
        assert_equal(0, wait_thread.value.exitstatus)
      end
    end
  end

  # $ sakai-info version
  def test_version
    Open3.popen3(CLI_ENV, "#{COMMAND} version") do |stdin, stdout, stderr, wait_thread|
      # stdout ought to match SakaiInfo::VERSION
      assert_equal(SakaiInfo::VERSION, stdout.readlines.join.chomp)

      # stderr ought to be empty
      assert_equal("", stderr.readlines.join)

      # exit code ought to be 0
      assert_equal(0, wait_thread.value.exitstatus)
    end
  end

  # TODO: test other sakai-info commands

  # $ sakai-info test
  def test_test
  end
end

