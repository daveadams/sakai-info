# sakai-info/cli.rb
#  - sakai-info command line tool support
#
# Created 2012-02-19 daveadams@gmail.com
# Last updated 2012-02-19 daveadams@gmail.com
#
# https://github.com/daveadams/sakai-info
#
# This software is public domain.
#

require 'sakai-info/cli/help'

module SakaiInfo
  class CLI
    def self.validate_config
      return true if Configuration.configured?

      begin
        Configuration.load_config
        return true
      rescue NoConfigFoundException
        STDERR.puts "ERROR: No configuration file was found at #{Configuration::DEFAULT_CONFIG_FILE}"
        return false
      rescue InvalidConfigException => e
        STDERR.puts "ERROR: Configuration was invalid:"
        e.message.each_line do |line|
          STDERR.puts "  #{line.chomp}"
        end
        return false
      end
    end
  end
end

